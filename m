From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] freezer: only show the state of tasks
	refusing to freeze
Date: Wed, 10 Mar 2010 23:00:19 +0100
Message-ID: <201003102300.19497.rjw__16940.9066359096$1268258449$gmane$org@sisk.pl>
References: <1268213322-5094-1-git-send-email-dfeng@redhat.com>
	<alpine.DEB.2.00.1003100252550.25220@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1003100252550.25220@chino.kir.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Rientjes <rientjes@google.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Xiaotian Feng <dfeng@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 March 2010, David Rientjes wrote:
> On Wed, 10 Mar 2010, Xiaotian Feng wrote:
> 
> > show_state will dump all tasks state, so if freezer failed to freeze
> > any task, kernel will dump all tasks state and flood the dmesg log.
> > This patch makes freezer only show state of tasks refusing to freeze.
> > 
> > Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > Cc: David Rientjes <rientjes@google.com>
> 
> Acked-by: David Rientjes <rientjes@google.com>

Applied.

Rafael
