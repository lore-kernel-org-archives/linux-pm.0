From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 2.6.34-rc3 doesn't suspend to disk (-rc2 did)
Date: Sat, 10 Apr 2010 22:04:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004102200510.8345__6539.54106751389$1270929956$gmane$org@pobox.suse.cz>
References: <alpine.LNX.2.00.1004020215100.8345@pobox.suse.cz>
	<201004082044.26949.maciej.rutecki@gmail.com>
	<4BC03A11.4050407@gmail.com> <4BC03B16.6000403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BC03B16.6000403@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, maciej.rutecki@gmail.com
List-Id: linux-pm@vger.kernel.org

On Sat, 10 Apr 2010, Jiri Slaby wrote:

> > Jiri, could you add there whether you changed config options somehow?
> > The bug drives me crazy.
> 
> (and check whether the fix there solves your problem or we hit different
> issues)

Yes, I can confirm that the patch fixes the issue I have been seeing as 
well (I have been testing with different DEBUG_BLOCK_EXT_DEVT setting with 
-rc2 and -rc3).

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
