From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Wed, 18 Jan 2012 09:52:52 +0200
Message-ID: <87ipk9qwff.fsf@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201162238.57556.rjw@sisk.pl>
	<87r4yyrh2e.fsf@amiettinen-lnx.nvidia.com>
	<201201172227.59080.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:
[..]
> If I understand you correctly, you want to have an iterface for specifying
> min and max frequencies from user space.  I can understand that.  At least
> I can see some use cases for that.
>
> Now, the question is if using the PM QoS framework is the right way to do
> that.
>
>> The change to cpufreq core just adds two read-only files to be able to
>> inspect user_policy.min/max in addition to the currently enforced
>> policy->min/max. Yes - there has been the possibility of using the sysfs
>> min for setting a frequency floor but this is problematic when there are
>> multiple clients. You'd need some kind of arbitration and book keeping
>> to set/restore the minimum. And PM QoS provides exactly this mechanism.
>
> Just as I suspected. :-)
>
> OK, so what's your anticipated usage model of this?

We've been experimenting with hooking the frequency boost to e.g. touch
screen UI events and application launch. I believe there are also some
specific applications that would want to either set a frequency floor or
ceiling in some situations.

>> I think the kernel needs to be extended to handle more PM constraints
>> and PM QoS is the closest thing I know for this kind of
>> functionality. However, I'm open to suggestions about alternative
>> approaches. I think we need e.g. more than just min/max "reduction
>> operators". Ideas, anyone?
>
> I first need to know who those multiple clients are going to be.
>
> Thanks,
> Rafael

For the touch screen UI, the boost could be implemented as a kernel
module hooked with suitable event filter to the input event
stream. Another possibility is the UI framework in user space. Some
specific user space applications would also be clients.

	--Antti
