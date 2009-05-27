From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 13351] 2.6.30 corrupts my system after suspend
	resume with readonly mounted hard disk
Date: Wed, 27 May 2009 22:45:02 +0200
Message-ID: <200905272245.03779.rjw__4295.95086393437$1243457207$gmane$org@sisk.pl>
References: <bug-13351-10028@http.bugzilla.kernel.org/>
	<200905272017.n4RKHN7J004784@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905272017.n4RKHN7J004784@demeter.kernel.org>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, bugzilla-daemon@bugzilla.kernel.org, unggnu@googlemail.com, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 27 May 2009, bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13351
> 
> --- Comment #23 from unggnu@googlemail.com  2009-05-27 20:17:22 ---
> According to bisect it is either 78a8b35bc7abf8b8333d6f625e08c0f7cc1c3742 or
> 6d7942dc2a70a7e74c352107b150265602671588
> The last version doesn't boot so I couldn't nail it down further.
> 
> I have bisect the commits between 2.6.29-rc8 and 2.6.30-rc1 .
> 
> I hope that this helps.

Thanks for bisecting.

We have a serious regression here which appears to have been caused by x86
patches.  Please help!

Best,
Rafael
