From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Use of parallel init threads for slow devices start
	ups?
Date: 20 Feb 2007 00:52:31 +0100
Message-ID: <p73hcthemdc.fsf@bingen.suse.de>
References: <3B6D69C3A9EBCA4BA5DA60D9130274295B9D66@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274295B9D66@dlee13.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

"Woodruff, Richard" <r-woodruff2@ti.com> writes:
> =

> Does anyone want to give an opinion on forking off a parallel thread to
> handle slower devices which are not dependent?

Recent kernels have CONFIG_PCI_MULTITHREAD_PROBE. But it's considered
highly experimental for now because of unknown races. =

I guess a lot of testing and fixing any bugs you hit would be welcome.

-Andi
