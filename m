From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
Date: Thu, 11 Oct 2007 12:17:57 +0200
Message-ID: <200710111217.58473.rjw__9069.21619684926$1192097055$gmane$org@sisk.pl>
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1192068833.27482.13.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 11 October 2007 04:13, Huang, Ying wrote:
> Kexec base hibernation has some potential advantages over uswsusp and
> TuxOnIce (suspend2). Some most obvious advantages are:

Well, I have some doubts as far as the obviousness is concerned.

> 1. The hibernation image size can exceed half of memory size easily.

This is also possible with TuxOnIce.

> 2. The hibernation image can be written to and read from almost
>    anywhere, such as USB disk, NFS.

This is possible with uswsusp, at least in theory, probably with TuxOnIce too.

> 3. It is possible to eliminate freezer from kexec based hibernation
>    implementation.

This isn't true as long as we have not changed the handling of devices
(which is in the works, but will take time).

> 4. Based on kexec/kdump implementation, the kernel code needed is
>    less.

Well, maybe.

Greetings,
Rafael
