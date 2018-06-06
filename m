From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 5/7] interconnect: qcom: Add msm8916 interconnect
 provider driver
Date: Wed, 6 Jun 2018 18:14:28 +0300
Message-ID: <0f03e7b9-aed6-b012-08da-5921061e3db2@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-6-georgi.djakov@linaro.org>
 <CAHLCerNnoNowC6CfNc7O9Nbj+xy0GGw0qmadOxzGsy5iSrOtOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHLCerNnoNowC6CfNc7O9Nbj+xy0GGw0qmadOxzGsy5iSrOtOg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, seansw@qti.qualcomm.com, davidai@quicinc.com, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, LKML <linux-kernel@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Amit,

On 25.05.18 г. 11:27, Amit Kucheria wrote:
> On Fri, Mar 9, 2018 at 11:09 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/Kconfig        |   5 +
>>  drivers/interconnect/Makefile       |   1 +
>>  drivers/interconnect/qcom/Kconfig   |  11 +
>>  drivers/interconnect/qcom/Makefile  |   2 +
>>  drivers/interconnect/qcom/msm8916.c | 482 ++++++++++++++++++++++++++++++++++++
>>  include/linux/interconnect/qcom.h   | 350 ++++++++++++++++++++++++++
>>  6 files changed, 851 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/Kconfig
>>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>>  create mode 100644 include/linux/interconnect/qcom.h

[..]

>> +#define DEFINE_QNODE(_name, _id, _port, _buswidth, _ap_owned,          \
>> +                       _mas_rpm_id, _slv_rpm_id, _qos_mode,            \
>> +                       _numlinks, ...)                                 \
>> +               static struct qcom_icc_node _name = {                   \
>> +               .id = _id,                                              \
>> +               .name = #_name,                                         \
>> +               .port = _port,                                          \
>> +               .buswidth = _buswidth,                                  \
>> +               .qos_mode = _qos_mode,                                  \
>> +               .ap_owned = _ap_owned,                                  \
>> +               .mas_rpm_id = _mas_rpm_id,                              \
>> +               .slv_rpm_id = _slv_rpm_id,                              \
>> +               .num_links = _numlinks,                                 \
>> +               .links = { __VA_ARGS__ },                               \
>> +       }
> 
> Move this macro definition just above its use below.
> 

Ok.

>> +enum qcom_qos_mode {
>> +       QCOM_QOS_MODE_BYPASS = 0,
>> +       QCOM_QOS_MODE_FIXED,
>> +       QCOM_QOS_MODE_MAX,
>> +};
>> +
>> +struct qcom_icc_provider {
>> +       struct icc_provider     provider;
>> +       void __iomem            *base;
>> +       struct clk              *bus_clk;
>> +       struct clk              *bus_a_clk;
>> +};
>> +
>> +#define MSM8916_MAX_LINKS      8
>> +
>> +/**
>> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
>> + * @name: the node name used in debugfs
>> + * @links: an array of nodes where we can go next while traversing
>> + * @id: a unique node identifier
>> + * @num_links: the total number of @links
>> + * @port: the offset index into the masters QoS register space
>> + * @buswidth: width of the interconnect between a node and the bus
> 
> units?

Will add.

[..]

>> +static int qcom_icc_init(struct icc_node *node)
>> +{
>> +       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
>> +       /* TODO: init qos and priority */
>> +
> 
> No need to set_rate here before enabling the clock?

Yes, i am planing to initially set the bus clocks at max rate. The rate
would be adjusted as soon as the consumers start placing requests.

> 
>> +       clk_prepare_enable(qp->bus_clk);
>> +       clk_prepare_enable(qp->bus_a_clk);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
>> +                       u32 avg, u32 peak)
>> +{
>> +       struct qcom_icc_provider *qp;
>> +       struct qcom_icc_node *qn;
>> +       struct icc_node *node;
>> +       struct icc_provider *provider;
>> +       u64 avg_bw;
>> +       u64 peak_bw;
>> +       u64 rate = 0;
>> +       int ret = 0;
>> +
>> +       if (!src)
>> +               node = dst;
>> +       else
>> +               node = src;
>> +
>> +       qn = node->data;
>> +       provider = node->provider;
>> +       qp = to_qcom_provider(node->provider);
>> +
>> +       /* convert from kbps to bps */
>> +       avg_bw = avg * 1000ULL;
>> +       peak_bw = peak * 1000ULL;
>> +
> 
> Since the core uses kbps and various SoC HW might use bps (or other
> units), perhaps consider providing a macro in the core header such as:
> 
> #define icc_units_to_bps(bw)  (bw * 1000ULL)
> 
> and then move this conversion to the top of the function where you
> define the variable
> 
> u64 avg_bw = icc_units_to_bps(avg);
> u64 peak_bw = icc_units_to_bps(peak);
> 
> Since other drivers will end up copying this driver, it might help
> prevent silly errors in the drivers and has a side-effect of allowing
> the core to change internal units w/o any driver changes down the
> line, if needed.

Ok, i am fine with this.

Thanks,
Georgi
