From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Sun, 8 Jul 2007 19:28:24 +0100
Message-ID: <20070708182824.GI21668__15312.8674290658$1183919465$gmane$org@ftp.linux.org.uk>
References: <200707050858.03638.oliver@neukum.org>
	<20070708123748.GB3866@ucw.cz>
	<E1I7Xfc-0008PO-00@dorka.pomaz.szeredi.hu>
	<200707082008.57879.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707082008.57879.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 08, 2007 at 08:08:56PM +0200, Rafael J. Wysocki wrote:
> Well, the system that cannot access its filesystems is not in a consistent
> state, so it generally is not reasonable to suspend or hibernate it.
> 
> In fact, NFS and similar filesystems should always be unmounted before the
> suspend/hibernation to avoid problems that may arise after the resume, if
> they become unavailable at that time.

Ah, thanks for clarifying that. [mentally putting the entire thing into
"unusable due to idiotic design imposing idiotic limitations" bin and
stepping out of this thread]
