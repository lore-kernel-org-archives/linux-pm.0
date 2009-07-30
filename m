From: =?UTF-8?B?Q8OpZHJpYyBHb2Rpbg==?= <cedric@belbone.be>
Subject: Re: [Bug 13865] Can only resume with HP_WMI selected on
 compaq nc6000 when 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca is reverted
Date: Thu, 30 Jul 2009 11:20:24 +0200
Message-ID: <4A7165D8.8060705__8096.75347195498$1248978155$gmane$org@belbone.be>
References: <bug-13865-10028@http.bugzilla.kernel.org/>
	<200907292257.41573.rjw@sisk.pl>
	<200907292331.34214.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907292331.34214.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, bugzilla-daemon@bugzilla.kernel.org
List-Id: linux-pm@vger.kernel.org

Frans Pop wrote:
> On Wednesday 29 July 2009, Rafael J. Wysocki wrote:
>   
>> On Wednesday 29 July 2009, you wrote:
>>     
>>> Just for testing I enabled HP_WMI. But from then, I could not resume
>>> anymore. I just reverted the last git commit on the
>>> 'drivers/platform/x86/hp-wmi.c' code
>>> (4c395bdd3f2ca8f7e8efad881e16071182c3b8ca) and now I can resume. The
>>> problem still persists on .31-rc serie
>>>       
>> Frans, that's something for you to take care of.
>>     
>
> I'll at least give it a try.
>
> Cedric, as a start, can you please provide the output of the following 
> commands after the system is booted and with hp-wmi loaded:
> $ grep . /sys/devices/platform/hp-wmi/*
> $ ls -l /dev/input/*
> $ cat /proc/bus/input/devices
>
> Does an unload and reload of the module work correctly? What gets output 
> in dmesg by that?
>
> The strange thing is that the resume function does not do anything that's 
> not also done in hp_wmi_input_setup(). The only thing I can think of is 
> that we might need to test for wmi_has_guid(HPWMI_EVENT_GUID) because 
> that model simply does not support input events.
>
> Cheers,
> FJP
>   
I tested your patch (from buzilla) and now I can resume.

Thanks ! You have my tested-by ;-)

PS: I suppose you don't need this infos anymore ?
