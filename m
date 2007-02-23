From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.21-rc1: T60 resume from suspend to RAM issues
Date: Fri, 23 Feb 2007 02:09:04 -0800
Message-ID: <20070223020904.c8fc8a3e.akpm@linux-foundation.org>
References: <20070222233803.GA4447@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070222233803.GA4447@mellanox.co.il>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-acpi@vger.kernel.org, mingo@redhat.com, len.brown@intel.com, bunk@stusta.de, linux-kernel@vger.kernel.org, linux-pm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> On Fri, 23 Feb 2007 01:38:03 +0200 "Michael S. Tsirkin" <mst@mellanox.co.=
il> wrote:
> I tested this:
> commit 9654640d0af8f2de40ff3807d3695109d3463f54
> and see 2 issues:
> =

> 1. After suspend to RAM, system wakes up but no screen.
> I can log in through ssh though.
> dmesg output at this point below.
> Works fine on 2.6.20 and below, with same .config
> .config and log file for this issue attached.
> =

> 2. As a separate test, I enabled DynTicks in .config.
> Seems to work fine but won't come out of suspend to memory at all:
> pressing Fn/F4 seems to have no effect.
> =


Do you believe that the second problem was caused by dynticks?
