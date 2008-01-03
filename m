From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/7] ACPI: Separate invocations of _GTS
	and _BFS from _PTS and _WAK
Date: Thu, 3 Jan 2008 11:42:20 +0100
Message-ID: <20080103104220.GA1732__1712.79302235252$1199357023$gmane$org@elf.ucw.cz>
References: <200712271903.53961.rjw@sisk.pl> <200712271915.17174.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712271915.17174.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-12-27 19:15:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The execution of ACPI global control methods _GTS and _BFS is
> currently tied to the preparation to enter a sleep state and to the
> leaving of the sleep state, respectively.  However, these functions
> are called before disabling the nonboot CPUs and after enabling
> them, respectively (in fact, on ACPI 1.0x systems the first of them
> ought to be called before suspending devices), while according to the
> ACPI specification, _GTS is to be executed right prior to entering
> the system sleep state and _BFS is to be executed right after the
> platfor firmware has returned control to the OS on wake up.
> 
> Move the execution of _GTS and _BFS to the right places.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Seems ok to me, but it is 2.6.25 material earliest, right?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
