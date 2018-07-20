From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v6 3/8] interconnect: Add debugfs support
Date: Fri, 20 Jul 2018 17:36:00 +0300
Message-ID: <3a0d35bb-f55a-28c0-f2a6-0f2b49422896@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-4-georgi.djakov@linaro.org>
 <20180715121507.GA17794@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180715121507.GA17794@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, abailon@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Greg,

On 15.07.18 г. 15:15, Greg KH wrote:
> On Mon, Jul 09, 2018 at 06:50:59PM +0300, Georgi Djakov wrote:
>> +static int __init icc_debugfs_init(void)
>> +{
>> +	struct dentry *file;
>> +
>> +	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
>> +	if (!icc_debugfs_dir) {
>> +		pr_err("interconnect: error creating debugfs directory\n");
>> +		return -ENODEV;
>> +	}
> 
> You should never care about the return value of a debugfs call.  Just
> ignore it and move on.

Ok!

>> +	file = debugfs_create_file("interconnect_summary", 0444,
>> +				   icc_debugfs_dir, NULL, &icc_summary_fops);
>> +	if (!file)
>> +		return -ENODEV;
> 
> Again, do not check this.
> 
> Where do you remove this directory and file from the system when the
> code shuts down?

Will take care of this! Thanks for the feedback!

Georgi
