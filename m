From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/2] cpumask: introduce cpumask for
	hotpluggable CPUs
Date: Wed, 10 Aug 2011 22:53:31 +0200
Message-ID: <4E42EFCB.1030005__7428.04541155255$1313009669$gmane$org@linaro.org>
References: <1313006614-28702-1-git-send-email-mturquette@ti.com>
	<1313006614-28702-2-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313006614-28702-2-git-send-email-mturquette@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/10/2011 10:03 PM, Mike Turquette wrote:
> On some platforms it is possible to have some CPUs which support CPU
> hotplug and some which do not.  Currently the prescence of an 'online'
> sysfs entry in userspace is adequate for applications to know that a CPU
> supports hotplug, but there is no convenient way to make the same
> determination in the kernel.
> 
> To better model this relationship this patch introduces a new cpumask to
> track CPUs that support CPU hotplug operations.
> 
> This new cpumask is populated at boot-time and remains static for the
> life of the machine.  Bits set in the mask indicate a CPU which supports
> hotplug, but make no guarantees about whether that CPU is currently
> online or not.  Likewise a cleared bit in the mask indicates either a
> CPU which cannot hotplug or a lack of a populated CPU.
> 
> The purpose of this new cpumask is to aid kernel code which uses CPU to
> take CPUs online and offline.  Possible uses are as a thermal event
> mitigation technique or as a power capping mechanism.
> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOQu/KAAoJEAKBbMCpUGYAxnoH/0+WtrRGq0oOjkU8jIxzAEUP
OW6S7EQT13v97YapaEwUZpHOzrdeEa9bV5sVI3uc3H9n6dnQbh25eMuhiH/dTwF6
LHV1Tdv7/+ghiSc4NJunpXjAsObezUgTV9n2Zoip3kAfhMdV5DntJu0Izkdb5lkA
AD5CqV6oHqC0spa2/nMMeOYsdp3hLP3hA5wCyE8a2rxvbytxl2jRVommXOpF3AnI
s3OS7oyVFLpdvxVdAio1cXvM6vILtJFArAqw88AJUBsUsuehRxeOYVvTR3/z4RZD
LNEH72IkGY/8OVYp9/VoixWgWTUhXUR5BZwAjCP7a+xQk/1qK1LAM+/CXimwND0=
=90gJ
-----END PGP SIGNATURE-----
