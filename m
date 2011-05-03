From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH] PM: Print a warning if firmware is
 requested when tasks are frozen
Date: Tue, 3 May 2011 07:06:08 -0700
Message-ID: <20110503140608.GB7944__42668.1770979942$1304433532$gmane$org@suse.de>
References: <201105030044.51661.rjw@sisk.pl> <50363.1304379012@localhost>
	<201105031302.08910.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105031302.08910.rjw@sisk.pl>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Valdis.Kletnieks@vt.edu, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 03, 2011 at 01:02:08PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Print a warning if firmware is requested when tasks are frozen
> 
> Some drivers erroneously use request_firmware() from their ->resume()
> (or ->thaw(), or ->restore()) callbacks, which is not going to work
> unless the firmware has been built in.  This causes system resume to
> stall until the firmware-loading timeout expires, which makes users
> think that the resume has failed and reboot their machines
> unnecessarily.  For this reason, make _request_firmware() print a
> warning and return immediately with error code if it has been called
> when tasks are frozen and it's impossible to start any new usermode
> helpers.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

I'm guessing you will take this through your tree?  If so, that's great:

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
