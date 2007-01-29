From: akuster <akuster@mvista.com>
Subject: Re: [PATCH 1/2] PM: fast power off - core
Date: Mon, 29 Jan 2007 08:08:33 -1000
Message-ID: <45BE3821.4080803@mvista.com>
References: <45BBA9D5.8020004@mvista.com> <20070128191241.GA13596@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070128191241.GA13596@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel-owner@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



Pavel Machek wrote:
> Hi!
> =

>> Fastpoweroff  allows a user to power down the system without using rc ki=
ll
>> scripts. This is used in the advent of a battery operated device about t=
o lose
>> power.  The user interface is vis sysfs /sys/power/fastpoweroff. A simpl=
e cat of
>> the fastpoweroff will list any registered profiles.  To invoke
>> the profile sequence, echo {profile name} > /sys/power/fastpoweroff.
> =

> No, we do not want "poweroff profiles" in kernel. Sorry.
No need to be.

> =

> rc kill scripts should be fast enough, if not, fix them. If it is
> impossible (time is spent in kernel waiting for network card to shut
> off), fix that.
> =

> What you want is pretty much "echo b > ..../sysrq; halt --now".

The one draw back is that Magic sysrq needs to be enabled and it might =

not be desired in a deployed system.  "echo u " is more of what I was =

looking for.

Thanks for you time.

Armin
