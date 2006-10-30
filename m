From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Date: Mon, 30 Oct 2006 10:16:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org>
References: <20061029231358.GI27968@stusta.de>
	<20061030135625.GB1601@mellanox.co.il>
	<45462591.7020200@ce.jp.nec.com>
	<Pine.LNX.4.64.0610300834060.25218@g5.osdl.org>
	<454637BE.6090309@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <454637BE.6090309@ce.jp.nec.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, linux-pm@osdl.org, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Adrian Bunk <bunk@stusta.de>, Martin Lorenz <martin@lorenz.eu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 30 Oct 2006, Jun'ichi Nomura wrote:
> =

> Please revert the patch. I'll fix the wrong error handling.
> =

> I'm not sure reverting the patch solves the ACPI problem
> because Michael's kernel seems not having any user of
> bd_claim_by_kobject.

Yeah, doing a grep does seem to imply that there is no way that those =

changes could matter.

Michael, can you double-check? I think Jun'ichi is right - in your kernel, =

according to the config posted on bugzilla, I don't think there should be =

a single caller of bd_claim_by_disk, since CONFIG_MD is disabled.

So it does seem strange. But if you bisected to that patch, and it =

reliably does _not_ have problems with the patch reverted, maybe there is =

some strange preprocessor thing that makes "grep" not find the caller.

Michael, you also reported:

> Reset to d7dd8fd9557840162b724a8ac1366dd78a12dff seems to hide part of =

> the issue (I have ACPI after kernel build, but not after =

> suspend/resume).  Both reverting this patch, and reset to the parent of
> this patch seem to solve (or at least, hide) both problems for me (no =

> ACPI after suspend/resume and no ACPI after kernel build).

(where that "d7dd8f.." is actually missing the initial "4" - I think you =

cut-and-pasted things incorrectly). =


So I wonder.. You still had ACPI working _after_ the kernel build even =

with that patch in place, and it seems that suspend/resume is the real =

issue. Martin Lorenz reports on the same bugzilla entry, and he only has =

problems with suspend/resume.

I assume that "compile the kernel" just triggers some magic ACPI event =

(probably fan-related due to heat), and I wonder if the bisection faked =

you out because once you get "close enough" the differences are small =

enough that the kernel compile is quick and the heat event doesn't =

actually trigger?

See what I'm saying? Maybe the act of bisecting itself changed the =

results, and then when you just revert the patch, you end up in the same =

situation: you only recompile a small part (you only recompile that =

particular file), and the problem doesn't occur, so you'd think that the =

revert "fixed" it.

If it's heat-related, it should probably trigger by anything that does a =

lot of CPU (and perhaps disk) accesses, not just kernel builds. It might =

be good to try to find another test-case for it than a kernel recompile, =

one that doesn't depend on how much changed in the kernel..

		Linus
