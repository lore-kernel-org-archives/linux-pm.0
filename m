From: Pavel Machek <pavel@suse.cz>
Subject: autosuspend for SCSI devices
Date: Fri, 22 Aug 2008 12:56:27 +0200
Message-ID: <20080822105626.GA9475__32191.835231106$1219437024$gmane$org@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: oneukum@suse.de, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, teheo@novell.com, stefanr@s5r6.in-berlin.de
Cc: Martin.Leisner@xerox.com
List-Id: linux-pm@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

Add support for autosuspend/autoresume of the SCSI devices. Lowlevel
driver can use it to spin the disk down... and it is neccessary step
for powering down the controllers.

Spinning down the disk is useful - saves ~0.5W here, and it is last
major thing we can do to save power on some small machines like
Kohjinsha subnotebooks.

Signed-off-by: Pavel Machek <pavel@suse.cz>



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
