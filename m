From: Uli Luckas <u.luckas@road.de>
Subject: Re: [RFC][PATCH -mm] PM: Prevent frozen user mode
	helpers from failing the freezing of tasks
Date: Wed, 20 Jun 2007 11:14:35 +0200
Message-ID: <200706201114.35876.u.luckas__21879.0296967656$1182331027$gmane$org@road.de>
References: <200706182329.58917.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706182329.58917.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday, 18. June 2007, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> At present, if a user mode helper is running while
> usermodehelper_pm_callback() is executed, the helper may be frozen and the
> completion in
> call_usermodehelper_exec() won't be completed until user space processes
> are thawed.  As a result, the freezing of kernel threads may fail, which is
> not desirable.
>
> Prevent this from happening by introducing a counter of running user mode
> helpers and allowing usermodehelper_pm_callback() to succeed for
> action = PM_HIBERNATION_PREPARE or action = PM_SUSPEND_PREPARE only if
> there are no helpers running.  [Namely, usermodehelper_pm_callback() waits
> for at most RUNNING_HELPERS_TIMEOUT for the number of running helpers to
> become zero and fails if that doesn't happen.]
>
> Special thanks to Uli Luckas <u.luckas@road.de> for reviewing the previous
> versions of this patch and for very useful comments.
>

Acked-by: Uli Luckas <u.luckas@road.de>

Regards,
Uli

-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 64 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing directors: Hans-Peter Constien, Hubertus von Streit
