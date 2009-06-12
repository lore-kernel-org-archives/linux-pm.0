From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 12/19] PM/Suspend: Do not shrink memory
	before suspend
Date: Fri, 12 Jun 2009 21:04:33 +0200
Message-ID: <200906122104.34958.rjw__7009.66318040646$1244833605$gmane$org@sisk.pl>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
	<S4AoGnG.A.6G.dgYMKB@chimera> <20090612110235.GL18682@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090612110235.GL18682@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Magnus Damm <damm@igel.co.jp>, Linux PM List <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Friday 12 June 2009, Pavel Machek wrote:
> On Thu 2009-06-11 22:39:03, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Remove the shrinking of memory from the suspend-to-RAM code, where
> > it is not really necessary.
> 
> I still have not seen any explanation why it is not neccessary.
> 
> It is true that I did not have time to stress my system to the point
> when it has 0 pages free, but we certainly know that it is possible,
> and we know that at least one driver allocates memory and will be
> broken if that happens.
> 
> NAK.

Sorry, I'm going to let Linus decide about this one.

Best,
Rafael
