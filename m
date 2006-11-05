From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
Date: Sun, 5 Nov 2006 15:26:07 +0200
Message-ID: <20061105132607.GA14245@mellanox.co.il>
References: <20061105064801.GV13381@stusta.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061105064801.GV13381@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, Linus Torvalds <torvalds@osdl.org>, linux-pm@osdl.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org

Quoting r. Adrian Bunk <bunk@stusta.de>:
> Subject    : ThinkPad T60/X60: lose ACPI events after suspend/resume
> References : http://lkml.org/lkml/2006/10/10/39
>              http://lkml.org/lkml/2006/10/4/425
>              http://lkml.org/lkml/2006/10/16/262
>              http://bugzilla.kernel.org/show_bug.cgi?id=3D7408
>              http://lkml.org/lkml/2006/10/30/251
>              http://lkml.org/lkml/2006/11/3/244
> Submitter  : Martin Lorenz <martin@lorenz.eu.org>
>              "Michael S. Tsirkin" <mst@mellanox.co.il>
> Status     : problem is being debugged

Add to that
http://lkml.org/lkml/2006/11/1/84
and a patch in
http://lkml.org/lkml/2006/11/1/294

I have been running f9dadfa71bc594df09044da61d1c72701121d802 which hs this =
patch
for several days now and this issue seem to be fixed.

I plan to re-test on -rc5 when that's out.

-- =

MST
