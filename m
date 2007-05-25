From: David Miller <davem@davemloft.net>
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Fri, 25 May 2007 13:36:53 -0700 (PDT)
Message-ID: <20070525.133653.57156321.davem__12419.3492149518$1180125463$gmane$org@davemloft.net>
References: <4656CE39.8050800@netunix.com>
	<alpine.LFD.0.98.0705250937550.26602@woody.linux-foundation.org>
	<46572507.6010800@netunix.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46572507.6010800@netunix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: crn@netunix.com
Cc: cherwin@gmail.com, krh@bitplanet.net, mikpe@it.uu.se, pavel@ucw.cz, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, alan@redhat.com, linux-pm@lists.linux-foundation.org, clameter@sgi.com, robert.de.rooy@gmail.com, htejun@gmail.com, michal.k.k.piotrowski@gmail.com, linux-pcmcia@lists.infradead.org, marcus@better.se, mingo@elte.hu, gregkh@suse.de, linux-kernel@vger.kernel.org, stefanr@s5r6.in-berlin.de, akpm@linux-foundation.org, arvidjaar@mail.ru, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Chris Newport <crn@netunix.com>
Date: Fri, 25 May 2007 19:03:51 +0100

> Not really a Solaris feature. This is a feature of the  Openboot  PROM
> which is also used by several other vendors.
> The Openboot PROM knows how to write to disk. The same should
> apply on Apple hardware and others which use the openboot
> convention.

This is totally unusable even if it weren't stupid, and as
someone who loves OpenBoot I think it's very stupid.

The reason it's unusable is that PowerPC already and sparc64 soon (in
order to support LDOMs) totally drops the OBP firmware very soon after
early kernel boot.  We pull in the device tree and then say "see ya"
to openboot.

PowerPC does it because sharing the address space with openboot is
next to impossible on that cpu, sparc64 will need to do it because
dynamic-reconfiguration of cpus in an LDOM is too hard to do with
openboot there.
