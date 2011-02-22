From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: 2.6.37.1 s2disk regression (TPM)
Date: Mon, 21 Feb 2011 19:42:21 -0500
Message-ID: <4D63066D.3080701__42626.2354980738$1298396388$gmane$org@linux.vnet.ibm.com>
References: <4D60E93D.1050205@gmail.com> <4D60F108.9000106@gmail.com>
	<201102201151.11635.rjw@sisk.pl> <201102201248.10779.rjw@sisk.pl>
	<4D628521.8000205@linux.vnet.ibm.com> <4D629427.8020500@gmail.com>
	<4D629D03.90801@linux.vnet.ibm.com> <4D62CD93.3040206@gmail.com>
	<4D62D930.8060304@linux.vnet.ibm.com> <4D62DCBA.9050609@gmail.com>
	<4D62E221.7010104@linux.vnet.ibm.com> <4D62E2F2.4060406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D62E2F2.4060406@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Rajiv Andrade <srajiv@linux.vnet.ibm.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, debora@linux.vnet.ibm.com, preining@logic.at, linux-pm <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/21/2011 05:10 PM, Jiri Slaby wrote:
> On 02/21/2011 11:07 PM, Rajiv Andrade wrote:
>> On 02/21/2011 06:44 PM, Jiri Slaby wrote:
>>> On 02/21/2011 10:29 PM, Stefan Berger wrote:
>>>> On 02/21/2011 03:39 PM, Jiri Slaby wrote:
>>>>> On 02/21/2011 06:12 PM, Rajiv Andrade wrote:
>>>>>> On 02/21/2011 01:34 PM, Jiri Slaby wrote:
>>>>>>> There has to be another problem which caused my regression. And
>>>>>>> since it
>>>>>>> reports "Operation Timed out", the former default timeout values
>>>>>>> worked
>>>>>>> for me, the ones read from TPM do not.
>>>>>> Yes, it's highly due inconsistent timeout values reported by the
>>>>>> TPM as
>>>>>> I mentioned, my working timeouts are:
>>>>>> 3020000 4510000 181000000
>>>>> 1000000 2000 150000
>>>>>
>>>>> Actually the first one from HW is 1. This is one is HZ after correction
>>>>> in get_timeout. So perhaps it is in ms, yes.
>>>> Following the specs, the timeouts are supposed to be in microseconds and
>>>> ascending order for short, medium and long duration. Of course, if the
>>>> device returns wrong timeouts, the command isn't going to succeed,
>>>> failing the suspend in this case. Nevertheless, I think we need the
>>>> patch I put in but at the same time we'll need a work-around for devices
>>>> like this.
>>> Yes, the patch is correct per se. But as it breaks bunch of machines it
>>> cannot go in now. The rule is no regressions.
>>>
>>> After you have the workaround it should go into the next rc1 after that.
>>> Do you plan to add a dmi-based quirk? Or, IOW do you want me to attach
>>> dmidecode output? Or are you going to base it solely on TPM
>>> manufacturer/version
>> It's more reliable to base the workaround on the values themselves,
>> instead of the TPM's ID, since
>> we don't know whether other models will behave similarly.
> As I wrote, you may base it on dmi data.
>
>> It should be fine then to extend the existing workaround for short
>> timeouts to the medium and long ones.
> OK, but how will you guess the values?
One way of doing it would be to at least make sure that the timeouts are

short < medium < long

and if that's not true, as in the case of your TPM, set the timeouts to 
0 and have Rajiv's work-around kick in  OR we assign the same high 
values to the timeouts explicily that Rajiv's work-around is using right 
now. Of course there could be another type of bad TPM firmware out there 
where all values are in ascending order but given in ms and cause 
time-outs -- but I would wait for someone to point that out since I am 
not aware of such a device.

Using the manufacturer, firmware version etc. to distinguish would 
probably open a can of worms...

    Stefan
