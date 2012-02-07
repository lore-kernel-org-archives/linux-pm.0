From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH] thermal: Add support to report cooling
 statistics achieved by cooling devices
Date: Tue, 7 Feb 2012 10:26:02 -0800
Message-ID: <CAK44p23TPO2r=4vuziGo9Ua42fqVNtQjGMWD8R00mDs7o_vzwg@mail.gmail.com>
References: <1326878467-17766-1-git-send-email-amit.kachhap@linaro.org>
	<20120206165658.GA28687@atrey.karlin.mff.cuni.cz>
	<20120206170348.GA19749@kroah.com>
	<CAK44p22FWxiXyBA1zbiuO0cbDScTSMRSV9pFDDMxXsc43ebGpw@mail.gmail.com>
	<20120207001818.GB30840@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120207001818.GB30840@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org
List-Id: linux-pm@vger.kernel.org

On 6 February 2012 16:18, Greg KH <greg@kroah.com> wrote:
> On Mon, Feb 06, 2012 at 03:16:17PM -0800, Amit Kachhap wrote:
>> On 6 February 2012 09:03, Greg KH <greg@kroah.com> wrote:
>> > On Mon, Feb 06, 2012 at 05:56:58PM +0100, Pavel Machek wrote:
>> >> Hi!
>> >>
>> >> > Add a sysfs node code to report effective cooling of all cooling devices
>> >> > attached to each trip points of a thermal zone. The cooling data reported
>> >> > will be absolute if the higher temperature trip points are arranged first
>> >> > otherwise the cooling stats is the cumulative effect of the earlier
>> >> > invoked cooling handlers.
>> >> >
>> >> > The basic assumption is that cooling devices will bring down the temperature
>> >> > in a symmetric manner and those statistics can be stored back and used for
>> >> > further tuning of the system.
>> >>
>> >> /sys fs should be one-value-per-file, talk to gregkh.
>> >
>> > That's correct.
>> >
>> > Why not use debugfs for this instead?
>> >
>> > thanks,
>> >
>> > greg k-h
>>
>> Thanks Greg/Pavel for looking into the patch.
>> Basically I checked the places where single sysfs entry is showing
>> more then 1 output. And
>> 1) /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state
>> 2) /sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table
>> are the places where the output is more than 1 value.
>
> Yes, those are two known-bad files, whose files will change soon and
> move to debugfs.
>
> Just because you found 2, instead of the thousands of other properly
> formatted files, does not mean you are allowed to create something like
> this.
>
>> Anyway I can enclose this sysfs inside CONFIG_THERMAL_COOLING_STATS macro.
>
> No, you can not create it at all in sysfs, if you really need such a
> large single file, use debugfs instead, that is what it is there for.
>
> Again, one-value-per-file is the sysfs rule, and has been for a decade
> now, please don't think this is a new thing.
>
> greg k-h

Ok I will follow one-value-per-file rule for sysfs file. Thanks
