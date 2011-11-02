From: =?UTF-8?Q?Damien_Th=C3=A9bault?= <damien.thebault@gmail.com>
Subject: Re: Resume problem,
 reboot instead of resume after suspend on Zepto Nox A14
Date: Wed, 2 Nov 2011 21:47:56 +0100
Message-ID: <CAEcrOvA4u52bONejq2dgRO-3XbX5oyispYvXShdsy-v+UesjWg@mail.gmail.com>
References: <CAEcrOvACd=zZ000t2niWM6DFgSuJOHyS1MEibwcA-=ouGfzU6w@mail.gmail.com>
	<CAJ0PZbT6_64Sg6NX+-Kshdn0T-1zynyUVkZ-hRCYtz6Fv_v4CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbT6_64Sg6NX+-Kshdn0T-1zynyUVkZ-hRCYtz6Fv_v4CA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 2, 2011 at 10:39, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
> [...]
> When core is used for pm_test, the platform_ops's enter() is not
> called. Thus, you are not actually testing the real suspend-to-RAM,
> you are testing everything suspend-related materials except for the
> real suspend-resume mechanism for the CPU.
>
> I'm not familiar with x86's ACPI; however, this looks like a
> resume-related problem.
> Probably, at the BIOS (or any other pre-BIOS stage?), the CPU cannot
> read the "the system has been suspended-to-RAM" message?
> or the resume routine of kernel is failing and the system resets or
> jumps to BIOS?
> , which are some issues we've experienced with ARM devices and its bootloaders.
>
> You'll probably need to examine the ACPI's suspend-to-RAM related bits
> or data structure at the platform_ops's enter() callback. And see if
> anything is corrupted or mis-configured.

I made some progress: with "nolapic" I'm able to get back to my
desktop, however if I make any fs access (like running an executable),
the system just locks. At least it doesn't reboot so it's an
improvement. I'll try so investigate further.

-- 
Damien Thebault
