From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v4 4/7] typec: tcpm: Add core support for sink side PPS
Date: Tue, 6 Feb 2018 14:33:08 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C1538@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <26195a73c6f2f379b47dd39f23db9c2feec20371.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130124653.GD14922@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.139]:16374 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751991AbeBFOdN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Feb 2018 09:33:13 -0500
In-Reply-To: <20180130124653.GD14922@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On 30 January 2018 12:47, Heikki Krogerus wrote:

> > +static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
> > +{
> > +	unsigned int target_mw;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&port->swap_lock);
> > +	mutex_lock(&port->lock);
> > +
> > +	if (!port->pps_data.active) {
> > +		ret = -EOPNOTSUPP;
> > +		goto port_unlock;
> > +	}
> > +
> > +	if (port->state != SNK_READY) {
> > +		ret = -EAGAIN;
> > +		goto port_unlock;
> > +	}
> > +
> > +	if (op_curr > port->pps_data.max_curr) {
> > +		ret = -EINVAL;
> > +		goto port_unlock;
> > +	}
> > +
> > +	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
> > +	if (target_mw < port->operating_snk_mw) {
> > +		ret = -EINVAL;
> > +		goto port_unlock;
> > +	}
> > +
> > +	reinit_completion(&port->pps_complete);
> > +	port->pps_data.op_curr = op_curr;
> > +	port->pps_status = 0;
> > +	port->pps_pending = true;
> > +	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
>
> Why not just take the swap_lock here..

I believe this would result in deadlock. All of the existing uses of swap_lock
acquire it first before the port->lock is then acquired (and vice-versa for
unlock). We don't want the power role to change during this procedure, so we
hold the swap_lock for the whole process. Have a look at tcpm_dr_set() and
tcpm_pr_set() as examples of existing usage.

> > +	return ret;
> > +}
> > +
> > +static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
> > +{
> > +	unsigned int target_mw;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&port->swap_lock);
> > +	mutex_lock(&port->lock);
> > +
> > +	if (!port->pps_data.active) {
> > +		ret = -EOPNOTSUPP;
> > +		goto port_unlock;
>
> Or, on top of what I said above, you could actually consider releasing
> the port lock here and just returning. Then you would not need those
> port_unlock and swap_unlock labels at all..
>
>                 mutex_unlock(&port->lock);
>                 return -EOPNOTSUPP;

Based on the comment above, I don't think this makes sense as you'd still need
to release the swap_lock as well, so there would be quite a lot of duplicated
code. Would prefer to stick with the present implementation.
