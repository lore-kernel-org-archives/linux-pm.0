From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 6 May 2010 10:40:18 +0900
Message-ID: <AANLkTinWEmlrBs5T_SX2h-YFY_OSgcDFLO18SuqZT9RN__4001.8834326931$1273110093$gmane$org@mail.gmail.com>
References: <20100504004338.GA22678@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005040949060.1729-100000@iolanthe.rowland.org>
	<20100504152724.GA2184@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100504152724.GA2184@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 5, 2010 at 12:27 AM, Matthew Garrett <mjg@redhat.com> wrote:
> On Tue, May 04, 2010 at 09:51:39AM -0400, Alan Stern wrote:
>
>> Another thing that Kevin is missing: There is more to the system than
>> the devices and the CPU. =A0For example: RAM, an embedded controller (on
>> modern desktop/laptop systems), a power supply, and so on. =A0Dynamic PM
>> for the CPU and the devices won't power-down these things, but system
>> PM will.
>
> Somewhat true - machines with C1E support will put the RAM into self
> refresh when the cpu is idle, but you're right that there are various
> components that we simply don't have control over in the desktop world
> at present.

As a contrast, at least on some embedded SoCs without firmware
limitations the low level sleep code for Runtime PM / CPU Idle is
shared with system wide suspend. So the RAM is put into self refresh
regardless of entering a half-deep CPU Idle state or entering
suspend-to-memory.

I've heard that newer SH-Mobile ARM hardware monitors the memory bus
activity behind the scenes and can put the system RAM into self
refresh automatically. On older parts we had to manage that from CPU
idle context.

/ magnus
