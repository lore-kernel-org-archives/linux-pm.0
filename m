From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8678] New: Kernel OOPSes when
	suspend/resume
Date: Tue, 26 Jun 2007 14:25:46 -0700
Message-ID: <20070626142546.dd529a93.akpm__44528.954398311$1182893240$gmane$org@linux-foundation.org>
References: <bug-8678-10286@http.bugzilla.kernel.org/>
	<200706261942.14722.cijoml@volny.cz>
	<200706262159.05917.rjw@sisk.pl>
	<200706262316.15007.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706262316.15007.cijoml@volny.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: CIJOML <cijoml@volny.cz>
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@kernel-bugs.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 26 Jun 2007 23:16:14 +0200
CIJOML <cijoml@volny.cz> wrote:

> > Can you please retest without DRM?
> >
> > Greetings,
> > Rafael
> 
> Ehm What is DRM??? Digital Right Management????

Direct-rendering manager: the thing which does accelerated 3d
in X.

Disable CONFIG_DRM in your .config.
