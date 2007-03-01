From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Thu, 1 Mar 2007 11:45:35 +0800
Message-ID: <b6a2187b0702281945n5f62a6b5w1c535de3ef9aaa8f@mail.gmail.com>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070226220152.GA29575@stusta.de>
	<20070228211318.GB4301@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070228211318.GB4301@mellanox.co.il>
Content-Disposition: inline
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
Cc: linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 3/1/07, Michael S. Tsirkin <mst@mellanox.co.il> wrote:

> with 2.6.20, pressing Fn/F4 generates an ACPI event and triggers suspend =
to RAM.
>
> On 2.6.21-rc2, after resume (when the box is accessible from network),
> pressing Fn/F4 again does not seem to have any effect.

I have the same problem on my IBM X60s on rc1 and rc2. Can't resume
from RAM, can't suspend to disk. It is possible to revert all the
changes to ACPI and test it?

Jeff.
