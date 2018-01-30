From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 4/7] typec: tcpm: Add core support for sink side PPS
Date: Tue, 30 Jan 2018 14:46:53 +0200
Message-ID: <20180130124653.GD14922@kuha.fi.intel.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <26195a73c6f2f379b47dd39f23db9c2feec20371.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <26195a73c6f2f379b47dd39f23db9c2feec20371.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 02, 2018 at 03:50:52PM +0000, Adam Thomson wrote:
> This commit adds code to handle requesting of PPS APDOs. Switching
> between standard PDOs and APDOs, and re-requesting an APDO to
> modify operating voltage/current will be triggered by an
> external call into TCPM.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  drivers/usb/typec/tcpm.c | 533 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/usb/pd.h   |   4 +-
>  include/linux/usb/tcpm.h |   2 +-
>  3 files changed, 525 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index f4d563e..b66d26c 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -47,6 +47,7 @@
>  	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
>  	S(SNK_WAIT_CAPABILITIES),		\
>  	S(SNK_NEGOTIATE_CAPABILITIES),		\
> +	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
>  	S(SNK_TRANSITION_SINK),			\
>  	S(SNK_TRANSITION_SINK_VBUS),		\
>  	S(SNK_READY),				\
> @@ -166,6 +167,16 @@ struct pd_mode_data {
>  	struct typec_altmode_desc altmode_desc[SVID_DISCOVERY_MAX];
>  };
>  
> +struct pd_pps_data {
> +	u32 min_volt;
> +	u32 max_volt;
> +	u32 max_curr;
> +	u32 out_volt;
> +	u32 op_curr;
> +	bool supported;
> +	bool active;
> +};
> +
>  struct tcpm_port {
>  	struct device *dev;
>  
> @@ -233,6 +244,7 @@ struct tcpm_port {
>  	struct completion swap_complete;
>  	int swap_status;
>  
> +	unsigned int negotiated_rev;
>  	unsigned int message_id;
>  	unsigned int caps_count;
>  	unsigned int hard_reset_count;
> @@ -255,6 +267,7 @@ struct tcpm_port {
>  	unsigned int nr_fixed; /* number of fixed sink PDOs */
>  	unsigned int nr_var; /* number of variable sink PDOs */
>  	unsigned int nr_batt; /* number of battery sink PDOs */
> +	unsigned int nr_apdo; /* number of APDO type PDOs */
>  	u32 snk_vdo[VDO_MAX_OBJECTS];
>  	unsigned int nr_snk_vdo;
>  
> @@ -262,6 +275,7 @@ struct tcpm_port {
>  	unsigned int max_snk_ma;
>  	unsigned int max_snk_mw;
>  	unsigned int operating_snk_mw;
> +	bool update_sink_caps;
>  
>  	/* Requested current / voltage */
>  	u32 current_limit;
> @@ -278,8 +292,13 @@ struct tcpm_port {
>  	/* VDO to retry if UFP responder replied busy */
>  	u32 vdo_retry;
>  
> -	/* Alternate mode data */
> +	/* PPS */
> +	struct pd_pps_data pps_data;
> +	struct completion pps_complete;
> +	bool pps_pending;
> +	int pps_status;
>  
> +	/* Alternate mode data */
>  	struct pd_mode_data mode_data;
>  	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX];
>  	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX];
> @@ -497,6 +516,16 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
>  				  pdo_max_voltage(pdo),
>  				  pdo_max_power(pdo));
>  			break;
> +		case PDO_TYPE_APDO:
> +			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
> +				scnprintf(msg, sizeof(msg),
> +					  "%u-%u mV, %u mA",
> +					  pdo_pps_apdo_min_voltage(pdo),
> +					  pdo_pps_apdo_max_voltage(pdo),
> +					  pdo_pps_apdo_max_current(pdo));
> +			else
> +				strcpy(msg, "undefined APDO");
> +			break;
>  		default:
>  			strcpy(msg, "undefined");
>  			break;
> @@ -791,11 +820,13 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>  		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
>  					  port->pwr_role,
>  					  port->data_role,
> +					  port->negotiated_rev,
>  					  port->message_id, 0);
>  	} else {
>  		msg.header = PD_HEADER_LE(PD_DATA_SOURCE_CAP,
>  					  port->pwr_role,
>  					  port->data_role,
> +					  port->negotiated_rev,
>  					  port->message_id,
>  					  port->nr_src_pdo);
>  	}
> @@ -816,11 +847,13 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>  		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
>  					  port->pwr_role,
>  					  port->data_role,
> +					  port->negotiated_rev,
>  					  port->message_id, 0);
>  	} else {
>  		msg.header = PD_HEADER_LE(PD_DATA_SINK_CAP,
>  					  port->pwr_role,
>  					  port->data_role,
> +					  port->negotiated_rev,
>  					  port->message_id,
>  					  port->nr_snk_pdo);
>  	}
> @@ -1187,6 +1220,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  		msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
>  					  port->pwr_role,
>  					  port->data_role,
> +					  port->negotiated_rev,
>  					  port->message_id, port->vdo_count);
>  		for (i = 0; i < port->vdo_count; i++)
>  			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
> @@ -1258,6 +1292,8 @@ enum pdo_err {
>  	PDO_ERR_FIXED_NOT_SORTED,
>  	PDO_ERR_VARIABLE_BATT_NOT_SORTED,
>  	PDO_ERR_DUPE_PDO,
> +	PDO_ERR_PPS_APDO_NOT_SORTED,
> +	PDO_ERR_DUPE_PPS_APDO,
>  };
>  
>  static const char * const pdo_err_msg[] = {
> @@ -1273,6 +1309,10 @@ enum pdo_err {
>  	" err: Variable/Battery supply pdos should be in increasing order of their minimum voltage",
>  	[PDO_ERR_DUPE_PDO] =
>  	" err: Variable/Batt supply pdos cannot have same min/max voltage",
> +	[PDO_ERR_PPS_APDO_NOT_SORTED] =
> +	" err: Programmable power supply apdos should be in increasing order of their maximum voltage",
> +	[PDO_ERR_DUPE_PPS_APDO] =
> +	" err: Programmable power supply apdos cannot have same min/max voltage and max current",
>  };
>  
>  static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
> @@ -1322,6 +1362,26 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
>  					  pdo_min_voltage(pdo[i - 1])))
>  					return PDO_ERR_DUPE_PDO;
>  				break;
> +			/*
> +			 * The Programmable Power Supply APDOs, if present,
> +			 * shall be sent in Maximum Voltage order;
> +			 * lowest to highest.
> +			 */
> +			case PDO_TYPE_APDO:
> +				if (pdo_apdo_type(pdo[i]) != APDO_TYPE_PPS)
> +					break;
> +
> +				if (pdo_pps_apdo_max_current(pdo[i]) <
> +				    pdo_pps_apdo_max_current(pdo[i - 1]))
> +					return PDO_ERR_PPS_APDO_NOT_SORTED;
> +				else if ((pdo_pps_apdo_min_voltage(pdo[i]) ==
> +					  pdo_pps_apdo_min_voltage(pdo[i - 1])) &&
> +					 (pdo_pps_apdo_max_voltage(pdo[i]) ==
> +					  pdo_pps_apdo_max_voltage(pdo[i - 1])) &&
> +					 (pdo_pps_apdo_max_current(pdo[i]) ==
> +					  pdo_pps_apdo_max_current(pdo[i - 1])))
> +					return PDO_ERR_DUPE_PPS_APDO;
> +				break;
>  			default:
>  				tcpm_log_force(port, " Unknown pdo type");
>  			}
> @@ -1347,11 +1407,16 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>  /*
>   * PD (data, control) command handling functions
>   */
> +
> +static int tcpm_pd_send_control(struct tcpm_port *port,
> +				enum pd_ctrl_msg_type type);
> +
>  static void tcpm_pd_data_request(struct tcpm_port *port,
>  				 const struct pd_message *msg)
>  {
>  	enum pd_data_msg_type type = pd_header_type_le(msg->header);
>  	unsigned int cnt = pd_header_cnt_le(msg->header);
> +	unsigned int rev = pd_header_rev_le(msg->header);
>  	unsigned int i;
>  
>  	switch (type) {
> @@ -1370,6 +1435,16 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  				   port->nr_source_caps);
>  
>  		/*
> +		 * Adjust revision in subsequent message headers, as required,
> +		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
> +		 * support Rev 1.0 so just do nothing in that scenario.
> +		 */
> +		if (rev == PD_REV10)
> +			break;
> +		else if (rev < PD_MAX_REV)
> +			port->negotiated_rev = rev;
> +
> +		/*
>  		 * This message may be received even if VBUS is not
>  		 * present. This is quite unexpected; see USB PD
>  		 * specification, sections 8.3.3.6.3.1 and 8.3.3.6.3.2.
> @@ -1390,6 +1465,19 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
>  			break;
>  		}
> +
> +		/*
> +		 * Adjust revision in subsequent message headers, as required,
> +		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
> +		 * support Rev 1.0 so just reject in that scenario.
> +		 */
> +		if (rev == PD_REV10) {
> +			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
> +			break;
> +		} else if (rev < PD_MAX_REV) {
> +			port->negotiated_rev = rev;
> +		}
> +
>  		port->sink_request = le32_to_cpu(msg->payload[0]);
>  		tcpm_set_state(port, SRC_NEGOTIATE_CAPABILITIES, 0);
>  		break;
> @@ -1414,6 +1502,15 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  	}
>  }
>  
> +static void tcpm_pps_complete(struct tcpm_port *port, int result)
> +{
> +	if (port->pps_pending) {
> +		port->pps_status = result;
> +		port->pps_pending = false;
> +		complete(&port->pps_complete);
> +	}
> +}
> +
>  static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  				 const struct pd_message *msg)
>  {
> @@ -1490,6 +1587,14 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  				next_state = SNK_WAIT_CAPABILITIES;
>  			tcpm_set_state(port, next_state, 0);
>  			break;
> +		case SNK_NEGOTIATE_PPS_CAPABILITIES:
> +			/* Revert data back from any requested PPS updates */
> +			port->pps_data.out_volt = port->supply_voltage;
> +			port->pps_data.op_curr = port->current_limit;
> +			port->pps_status = (type == PD_CTRL_WAIT ?
> +					    -EAGAIN : -EOPNOTSUPP);
> +			tcpm_set_state(port, SNK_READY, 0);
> +			break;
>  		case DR_SWAP_SEND:
>  			port->swap_status = (type == PD_CTRL_WAIT ?
>  					     -EAGAIN : -EOPNOTSUPP);
> @@ -1512,6 +1617,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  	case PD_CTRL_ACCEPT:
>  		switch (port->state) {
>  		case SNK_NEGOTIATE_CAPABILITIES:
> +			port->pps_data.active = false;
> +			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
> +			break;
> +		case SNK_NEGOTIATE_PPS_CAPABILITIES:
> +			port->pps_data.active = true;
> +			port->supply_voltage = port->pps_data.out_volt;
> +			port->current_limit = port->pps_data.op_curr;
>  			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>  			break;
>  		case SOFT_RESET_SEND:
> @@ -1666,6 +1778,7 @@ static int tcpm_pd_send_control(struct tcpm_port *port,
>  	memset(&msg, 0, sizeof(msg));
>  	msg.header = PD_HEADER_LE(type, port->pwr_role,
>  				  port->data_role,
> +				  port->negotiated_rev,
>  				  port->message_id, 0);
>  
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> @@ -1779,6 +1892,8 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  	unsigned int i, j, max_mw = 0, max_mv = 0, mw = 0, mv = 0, ma = 0;
>  	int ret = -EINVAL;
>  
> +	port->pps_data.supported = false;
> +
>  	/*
>  	 * Select the source PDO providing the most power which has a
>  	 * matchig sink cap.
> @@ -1787,7 +1902,8 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  		u32 pdo = port->source_caps[i];
>  		enum pd_pdo_type type = pdo_type(pdo);
>  
> -		if (type == PDO_TYPE_FIXED) {
> +		switch (type) {
> +		case PDO_TYPE_FIXED:
>  			for (j = 0; j < port->nr_fixed; j++) {
>  				if (pdo_fixed_voltage(pdo) ==
>  				    pdo_fixed_voltage(port->snk_pdo[j])) {
> @@ -1809,7 +1925,8 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  					break;
>  				}
>  			}
> -		} else if (type == PDO_TYPE_BATT) {
> +			break;
> +		case PDO_TYPE_BATT:
>  			for (j = port->nr_fixed;
>  			     j < port->nr_fixed +
>  				 port->nr_batt;
> @@ -1830,7 +1947,8 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  					}
>  				}
>  			}
> -		} else if (type == PDO_TYPE_VAR) {
> +			break;
> +		case PDO_TYPE_VAR:
>  			for (j = port->nr_fixed +
>  				 port->nr_batt;
>  			     j < port->nr_fixed +
> @@ -1854,12 +1972,98 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  					}
>  				}
>  			}
> +			break;
> +		case PDO_TYPE_APDO:
> +			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
> +				port->pps_data.supported = true;
> +			continue;
> +		default:
> +			tcpm_log(port, "Invalid PDO type, ignoring");
> +			continue;
>  		}
>  	}
>  
>  	return ret;
>  }
>  
> +#define min_pps_apdo_current(x, y)	\
> +	min(pdo_pps_apdo_max_current(x), pdo_pps_apdo_max_current(y))
> +
> +static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port,
> +					    int *snk_pdo, int *src_pdo)
> +{
> +	unsigned int i, j, max_mw = 0, max_mv = 0, mw = 0, mv = 0, ma = 0;
> +	enum pd_pdo_type type;
> +	u32 pdo;
> +	int ret = -EOPNOTSUPP;
> +
> +	/*
> +	 * Select the source PPS APDO providing the most power while staying
> +	 * within the board's limits. We skip the first PDO as this is always
> +	 * 5V 3A.
> +	 */
> +	*src_pdo = 0;
> +	for (i = 1; i < port->nr_source_caps; ++i) {
> +		pdo = port->source_caps[i];
> +		type = pdo_type(pdo);
> +
> +		switch (type) {
> +		case PDO_TYPE_APDO:
> +			if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
> +				tcpm_log(port, "Not PPS APDO, ignoring");
> +				continue;
> +			}
> +
> +			for (j = port->nr_fixed +
> +				 port->nr_batt +
> +				 port->nr_var;
> +			     j < port->nr_fixed +
> +				 port->nr_batt +
> +				 port->nr_var +
> +				 port->nr_apdo;
> +			     ++j) {
> +				if ((pdo_pps_apdo_min_voltage(pdo) >=
> +				     pdo_pps_apdo_min_voltage(port->snk_pdo[j])) &&
> +				    (pdo_pps_apdo_max_voltage(pdo) <=
> +				     pdo_pps_apdo_max_voltage(port->snk_pdo[j]))) {
> +					ma = min_pps_apdo_current(pdo,
> +								  port->snk_pdo[j]);
> +					mv = pdo_pps_apdo_max_voltage(pdo);
> +					mw = (ma * mv) / 1000;
> +					if ((mw > max_mw) ||
> +					    ((mw == max_mw) && (mv > max_mv))) {
> +						ret = 0;
> +						*src_pdo = i;
> +						*snk_pdo = j;
> +						max_mw = mw;
> +						max_mv = mv;
> +					}
> +				}
> +			}
> +
> +			break;
> +		default:
> +			tcpm_log(port, "Not APDO type, ignoring");
> +			continue;
> +		}
> +	}
> +
> +	if (*src_pdo > 0) {
> +		pdo = port->source_caps[*src_pdo];
> +
> +		port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
> +		port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
> +		port->pps_data.max_curr =
> +			min_pps_apdo_current(pdo, port->snk_pdo[*snk_pdo]);
> +		port->pps_data.out_volt =
> +			min(port->pps_data.out_volt, pdo_pps_apdo_max_voltage(pdo));
> +		port->pps_data.op_curr =
> +			min(port->pps_data.op_curr, pdo_pps_apdo_max_current(pdo));
> +	}
> +
> +	return ret;
> +}
> +
>  static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
>  {
>  	unsigned int mv, ma, mw, flags;
> @@ -1875,10 +2079,18 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
>  	matching_snk_pdo = port->snk_pdo[snk_pdo_index];
>  	type = pdo_type(pdo);
>  
> -	if (type == PDO_TYPE_FIXED)
> +	switch (type) {
> +	case PDO_TYPE_FIXED:
>  		mv = pdo_fixed_voltage(pdo);
> -	else
> +		break;
> +	case PDO_TYPE_BATT:
> +	case PDO_TYPE_VAR:
>  		mv = pdo_min_voltage(pdo);
> +		break;
> +	default:
> +		tcpm_log(port, "Invalid PDO selected!");
> +		return -EINVAL;
> +	}
>  
>  	/* Select maximum available current within the sink pdo's limit */
>  	if (type == PDO_TYPE_BATT) {
> @@ -1943,6 +2155,107 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
>  	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
>  				  port->pwr_role,
>  				  port->data_role,
> +				  port->negotiated_rev,
> +				  port->message_id, 1);
> +	msg.payload[0] = cpu_to_le32(rdo);
> +
> +	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> +}
> +
> +static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
> +{
> +	unsigned int out_mv, op_ma, op_mw, min_mv, max_mv, max_ma, flags;
> +	enum pd_pdo_type type;
> +	int src_pdo_index, snk_pdo_index;
> +	u32 pdo, matching_snk_pdo;
> +	int ret;
> +
> +	ret = tcpm_pd_select_pps_apdo(port, &snk_pdo_index, &src_pdo_index);
> +	if (ret)
> +		return ret;
> +
> +	pdo = port->source_caps[src_pdo_index];
> +	matching_snk_pdo = port->snk_pdo[snk_pdo_index];
> +	type = pdo_type(pdo);
> +
> +	switch (type) {
> +	case PDO_TYPE_APDO:
> +		if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
> +			tcpm_log(port, "Invalid APDO selected!");
> +			return -EINVAL;
> +		}
> +		min_mv = pdo_pps_apdo_min_voltage(pdo);
> +		max_mv = pdo_pps_apdo_max_voltage(pdo);
> +		max_ma = pdo_pps_apdo_max_current(pdo);
> +		out_mv = port->pps_data.out_volt;
> +		op_ma = port->pps_data.op_curr;
> +		break;
> +	default:
> +		tcpm_log(port, "Invalid PDO selected!");
> +		return -EINVAL;
> +	}
> +
> +	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
> +
> +	op_mw = (op_ma * out_mv) / 1000;
> +	if (op_mw < port->operating_snk_mw) {
> +		/*
> +		 * Try raising current to meet power needs. If that's not enough
> +		 * then try upping the voltage. If that's still not enoguh
> +		 * then we've obviously chosen a PPS APDO which really isn't
> +		 * suitable so abandon ship.
> +		 */
> +		op_ma = ((port->operating_snk_mw * 1000) / out_mv);
> +		if ((port->operating_snk_mw * 1000) % out_mv)
> +			++op_ma;
> +		op_ma += RDO_PROG_CURR_MA_STEP - (op_ma % RDO_PROG_CURR_MA_STEP);
> +
> +		if (op_ma > max_ma) {
> +			op_ma = max_ma;
> +			out_mv = ((port->operating_snk_mw * 1000) / op_ma);
> +			if ((port->operating_snk_mw * 1000) % op_ma)
> +				++out_mv;
> +			out_mv += RDO_PROG_VOLT_MV_STEP -
> +				  (out_mv % RDO_PROG_VOLT_MV_STEP);
> +
> +			if (out_mv > max_mv) {
> +				tcpm_log(port, "Invalid PPS APDO selected!");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	tcpm_log(port, "cc=%d cc1=%d cc2=%d vbus=%d vconn=%s polarity=%d",
> +		 port->cc_req, port->cc1, port->cc2, port->vbus_source,
> +		 port->vconn_role == TYPEC_SOURCE ? "source" : "sink",
> +		 port->polarity);
> +
> +	*rdo = RDO_PROG(src_pdo_index + 1, out_mv, op_ma, flags);
> +
> +	tcpm_log(port, "Requesting APDO %d: %u mV, %u mA",
> +		 src_pdo_index, out_mv, op_ma);
> +
> +	port->pps_data.op_curr = op_ma;
> +	port->pps_data.out_volt = out_mv;
> +
> +	return 0;
> +}
> +
> +static int tcpm_pd_send_pps_request(struct tcpm_port *port)
> +{
> +	struct pd_message msg;
> +	int ret;
> +	u32 rdo;
> +
> +	ret = tcpm_pd_build_pps_request(port, &rdo);
> +	if (ret < 0)
> +		return ret;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
> +				  port->pwr_role,
> +				  port->data_role,
> +				  port->negotiated_rev,
>  				  port->message_id, 1);
>  	msg.payload[0] = cpu_to_le32(rdo);
>  
> @@ -2128,6 +2441,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	tcpm_typec_disconnect(port);
>  	port->attached = false;
>  	port->pd_capable = false;
> +	port->pps_data.supported = false;
>  
>  	/*
>  	 * First Rx ID should be 0; set this to a sentinel of -1 so that
> @@ -2143,6 +2457,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
>  	tcpm_set_attached_state(port, false);
>  	port->try_src_count = 0;
>  	port->try_snk_count = 0;
> +	port->supply_voltage = 0;
> +	port->current_limit = 0;
>  }
>  
>  static void tcpm_detach(struct tcpm_port *port)
> @@ -2389,6 +2705,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		typec_set_pwr_opmode(port->typec_port, opmode);
>  		port->pwr_opmode = TYPEC_PWR_MODE_USB;
>  		port->caps_count = 0;
> +		port->negotiated_rev = PD_MAX_REV;
>  		port->message_id = 0;
>  		port->rx_msgid = -1;
>  		port->explicit_contract = false;
> @@ -2449,6 +2766,7 @@ static void run_state_machine(struct tcpm_port *port)
>  
>  		tcpm_swap_complete(port, 0);
>  		tcpm_typec_connect(port);
> +
>  		tcpm_check_send_discover(port);
>  		/*
>  		 * 6.3.5
> @@ -2472,6 +2790,7 @@ static void run_state_machine(struct tcpm_port *port)
>  	case SNK_UNATTACHED:
>  		if (!port->non_pd_role_swap)
>  			tcpm_swap_complete(port, -ENOTCONN);
> +		tcpm_pps_complete(port, -ENOTCONN);
>  		tcpm_snk_detach(port);
>  		if (tcpm_start_drp_toggling(port)) {
>  			tcpm_set_state(port, DRP_TOGGLING, 0);
> @@ -2480,6 +2799,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_cc(port, TYPEC_CC_RD);
>  		if (port->port_type == TYPEC_PORT_DRP)
>  			tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
> +
>  		break;
>  	case SNK_ATTACH_WAIT:
>  		if ((port->cc1 == TYPEC_CC_OPEN &&
> @@ -2561,6 +2881,7 @@ static void run_state_machine(struct tcpm_port *port)
>  					      port->cc2 : port->cc1);
>  		typec_set_pwr_opmode(port->typec_port, opmode);
>  		port->pwr_opmode = TYPEC_PWR_MODE_USB;
> +		port->negotiated_rev = PD_MAX_REV;
>  		port->message_id = 0;
>  		port->rx_msgid = -1;
>  		port->explicit_contract = false;
> @@ -2631,6 +2952,24 @@ static void run_state_machine(struct tcpm_port *port)
>  					    PD_T_SENDER_RESPONSE);
>  		}
>  		break;
> +	case SNK_NEGOTIATE_PPS_CAPABILITIES:
> +		ret = tcpm_pd_send_pps_request(port);
> +		if (ret < 0) {
> +			port->pps_status = ret;
> +			/*
> +			 * If this was called due to updates to sink
> +			 * capabilities, and pps is no longer valid, we should
> +			 * safely fall back to a standard PDO.
> +			 */
> +			if (port->update_sink_caps)
> +				tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
> +			else
> +				tcpm_set_state(port, SNK_READY, 0);
> +		} else {
> +			tcpm_set_state_cond(port, hard_reset_state(port),
> +					    PD_T_SENDER_RESPONSE);
> +		}
> +		break;
>  	case SNK_TRANSITION_SINK:
>  	case SNK_TRANSITION_SINK_VBUS:
>  		tcpm_set_state(port, hard_reset_state(port),
> @@ -2638,6 +2977,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_READY:
>  		port->try_snk_count = 0;
> +		port->update_sink_caps = false;
>  		if (port->explicit_contract) {
>  			typec_set_pwr_opmode(port->typec_port,
>  					     TYPEC_PWR_MODE_PD);
> @@ -2646,7 +2986,11 @@ static void run_state_machine(struct tcpm_port *port)
>  
>  		tcpm_swap_complete(port, 0);
>  		tcpm_typec_connect(port);
> +
>  		tcpm_check_send_discover(port);
> +
> +		tcpm_pps_complete(port, port->pps_status);
> +
>  		break;
>  
>  	/* Accessory states */
> @@ -2693,6 +3037,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
>  		break;
>  	case SNK_HARD_RESET_SINK_OFF:
> +		memset(&port->pps_data, 0, sizeof(port->pps_data));
>  		tcpm_set_vconn(port, false);
>  		tcpm_set_charge(port, false);
>  		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
> @@ -2913,6 +3258,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case ERROR_RECOVERY:
>  		tcpm_swap_complete(port, -EPROTO);
> +		tcpm_pps_complete(port, -EPROTO);
>  		tcpm_set_state(port, PORT_RESET, 0);
>  		break;
>  	case PORT_RESET:
> @@ -3378,7 +3724,7 @@ static int tcpm_dr_set(const struct typec_capability *cap,
>  	mutex_unlock(&port->lock);
>  
>  	if (!wait_for_completion_timeout(&port->swap_complete,
> -				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
>  		ret = -ETIMEDOUT;
>  	else
>  		ret = port->swap_status;
> @@ -3423,7 +3769,7 @@ static int tcpm_pr_set(const struct typec_capability *cap,
>  	mutex_unlock(&port->lock);
>  
>  	if (!wait_for_completion_timeout(&port->swap_complete,
> -				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
>  		ret = -ETIMEDOUT;
>  	else
>  		ret = port->swap_status;
> @@ -3463,7 +3809,7 @@ static int tcpm_vconn_set(const struct typec_capability *cap,
>  	mutex_unlock(&port->lock);
>  
>  	if (!wait_for_completion_timeout(&port->swap_complete,
> -				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
>  		ret = -ETIMEDOUT;
>  	else
>  		ret = port->swap_status;
> @@ -3495,6 +3841,162 @@ static int tcpm_try_role(const struct typec_capability *cap, int role)
>  	return ret;
>  }
>  
> +static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
> +{
> +	unsigned int target_mw;
> +	int ret = 0;
> +
> +	mutex_lock(&port->swap_lock);
> +	mutex_lock(&port->lock);
> +
> +	if (!port->pps_data.active) {
> +		ret = -EOPNOTSUPP;
> +		goto port_unlock;
> +	}
> +
> +	if (port->state != SNK_READY) {
> +		ret = -EAGAIN;
> +		goto port_unlock;
> +	}
> +
> +	if (op_curr > port->pps_data.max_curr) {
> +		ret = -EINVAL;
> +		goto port_unlock;
> +	}
> +
> +	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
> +	if (target_mw < port->operating_snk_mw) {
> +		ret = -EINVAL;
> +		goto port_unlock;
> +	}
> +
> +	reinit_completion(&port->pps_complete);
> +	port->pps_data.op_curr = op_curr;
> +	port->pps_status = 0;
> +	port->pps_pending = true;
> +	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);

Why not just take the swap_lock here..

> +	mutex_unlock(&port->lock);
> +
> +	if (!wait_for_completion_timeout(&port->pps_complete,
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = port->pps_status;
> +
> +	goto swap_unlock;

and you don't need that goto..

> +port_unlock:
> +	mutex_unlock(&port->lock);
> +swap_unlock:
> +	mutex_unlock(&port->swap_lock);

and this becomes..

	mutex_unlock(&port->swap_lock);
        return ret;

port_unlock:
	mutex_unlock(&port->lock);
        return ret;

> +	return ret;
> +}
> +
> +static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
> +{
> +	unsigned int target_mw;
> +	int ret = 0;
> +
> +	mutex_lock(&port->swap_lock);
> +	mutex_lock(&port->lock);
> +
> +	if (!port->pps_data.active) {
> +		ret = -EOPNOTSUPP;
> +		goto port_unlock;

Or, on top of what I said above, you could actually consider releasing
the port lock here and just returning. Then you would not need those
port_unlock and swap_unlock labels at all..

                mutex_unlock(&port->lock);
                return -EOPNOTSUPP;

> +	}
> +
> +	if (port->state != SNK_READY) {
> +		ret = -EAGAIN;
> +		goto port_unlock;

                mutex_unlock(&port->lock);
                return -EAGAIN;
> +	}
> +
> +	if ((out_volt < port->pps_data.min_volt) ||
> +	    (out_volt > port->pps_data.max_volt)) {
> +		ret = -EINVAL;
> +		goto port_unlock;

                mutex_unlock(&port->lock);
                return -EINVAL;

> +	}
> +
> +	target_mw = (port->pps_data.op_curr * out_volt) / 1000;
> +	if (target_mw < port->operating_snk_mw) {
> +		ret = -EINVAL;
> +		goto port_unlock;

                mutex_unlock(&port->lock);
                return -EINVAL;
> +	}
> +
> +	reinit_completion(&port->pps_complete);
> +	port->pps_data.out_volt = out_volt;
> +	port->pps_status = 0;
> +	port->pps_pending = true;
> +	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);

        mutex_lock(&port->swap_lock);

> +	mutex_unlock(&port->lock);
> +
> +	if (!wait_for_completion_timeout(&port->pps_complete,
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = port->pps_status;

        mutex_unlock(&port->swap_lock);

        return ret;

> +	goto swap_unlock;
> +
> +port_unlock:
> +	mutex_unlock(&port->lock);
> +swap_unlock:
> +	mutex_unlock(&port->swap_lock);
> +
> +	return ret;
> +}
> +
> +static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&port->swap_lock);
> +	mutex_lock(&port->lock);
> +
> +	if (!port->pps_data.supported) {
> +		ret = -EOPNOTSUPP;
> +		goto port_unlock;
> +	}
> +
> +	/* Trying to deactivate PPS when already deactivated so just bail */
> +	if ((!port->pps_data.active) && (!activate))
> +		goto port_unlock;
> +
> +	if (port->state != SNK_READY) {
> +		ret = -EAGAIN;
> +		goto port_unlock;
> +	}
> +
> +	reinit_completion(&port->pps_complete);
> +	port->pps_status = 0;
> +	port->pps_pending = true;
> +
> +	/* Trigger PPS request or move back to standard PDO contract */
> +	if (activate) {
> +		port->pps_data.out_volt = port->supply_voltage;
> +		port->pps_data.op_curr = port->current_limit;
> +		tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
> +	} else {
> +		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
> +	}
> +	mutex_unlock(&port->lock);
> +
> +	if (!wait_for_completion_timeout(&port->pps_complete,
> +				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = port->pps_status;
> +
> +	goto swap_unlock;
> +
> +port_unlock:
> +	mutex_unlock(&port->lock);
> +swap_unlock:
> +	mutex_unlock(&port->swap_lock);

You can do the same as above here as well.

> +	return ret;
> +}
> +
>  static void tcpm_init(struct tcpm_port *port)
>  {
>  	enum typec_cc_status cc1, cc2;
> @@ -3634,13 +4136,18 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
>  	port->max_snk_ma = max_snk_ma;
>  	port->max_snk_mw = max_snk_mw;
>  	port->operating_snk_mw = operating_snk_mw;
> +	port->update_sink_caps = true;
>  
>  	switch (port->state) {
>  	case SNK_NEGOTIATE_CAPABILITIES:
> +	case SNK_NEGOTIATE_PPS_CAPABILITIES:
>  	case SNK_READY:
>  	case SNK_TRANSITION_SINK:
>  	case SNK_TRANSITION_SINK_VBUS:
> -		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
> +		if (port->pps_data.active)
> +			tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
> +		else
> +			tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
>  		break;
>  	default:
>  		break;
> @@ -3695,6 +4202,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  
>  	init_completion(&port->tx_complete);
>  	init_completion(&port->swap_complete);
> +	init_completion(&port->pps_complete);
>  	tcpm_debugfs_init(port);
>  
>  	if (tcpm_validate_caps(port, tcpc->config->src_pdo,
> @@ -3717,6 +4225,9 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	port->nr_batt = nr_type_pdos(port->snk_pdo,
>  				     port->nr_snk_pdo,
>  				     PDO_TYPE_BATT);
> +	port->nr_apdo = nr_type_pdos(port->snk_pdo,
> +				     port->nr_snk_pdo,
> +				     PDO_TYPE_APDO);
>  	port->nr_snk_vdo = tcpm_copy_vdos(port->snk_vdo, tcpc->config->snk_vdo,
>  					  tcpc->config->nr_snk_vdo);
>  
> @@ -3732,7 +4243,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	port->typec_caps.prefer_role = tcpc->config->default_role;
>  	port->typec_caps.type = tcpc->config->type;
>  	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
> -	port->typec_caps.pd_revision = 0x0200;	/* USB-PD spec release 2.0 */
> +	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
>  	port->typec_caps.dr_set = tcpm_dr_set;
>  	port->typec_caps.pr_set = tcpm_pr_set;
>  	port->typec_caps.vconn_set = tcpm_vconn_set;
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index ff359bdf..09b570f 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -103,8 +103,8 @@ enum pd_ext_msg_type {
>  	 (((cnt) & PD_HEADER_CNT_MASK) << PD_HEADER_CNT_SHIFT) |	\
>  	 ((ext_hdr) ? PD_HEADER_EXT_HDR : 0))
>  
> -#define PD_HEADER_LE(type, pwr, data, id, cnt) \
> -	cpu_to_le16(PD_HEADER((type), (pwr), (data), PD_REV20, (id), (cnt), (0)))
> +#define PD_HEADER_LE(type, pwr, data, rev, id, cnt) \
> +	cpu_to_le16(PD_HEADER((type), (pwr), (data), (rev), (id), (cnt), (0)))
>  
>  static inline unsigned int pd_header_cnt(u16 header)
>  {
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index ca1c0b5..d6673f7 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -35,7 +35,7 @@ enum typec_cc_polarity {
>  
>  /* Time to wait for TCPC to complete transmit */
>  #define PD_T_TCPC_TX_TIMEOUT	100		/* in ms	*/
> -#define PD_ROLE_SWAP_TIMEOUT	(MSEC_PER_SEC * 10)
> +#define PD_STATE_MACHINE_TIMEOUT	(MSEC_PER_SEC * 10)
>  
>  enum tcpm_transmit_status {
>  	TCPC_TX_SUCCESS = 0,
> -- 
> 1.9.1

-- 
heikki
