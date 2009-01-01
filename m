From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Thu, 1 Jan 2009 23:42:18 +0000 (GMT)
Message-ID: <26416.81498.qm__45060.5835918852$1230910753$gmane$org@web23106.mail.ird.yahoo.com>
References: <Pine.LNX.4.44L0.0901011724590.5737-100000@netrider.rowland.org>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901011724590.5737-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-pm@lists.linux-foundation.org, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

--- On Thu, 1/1/09, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 1 Jan 2009, Hin-Tak Leung wrote:
> 
> > Also since Alan Stern is now CC'ed, can I ask the
> in-tree skeleton
> > usb driver code updated to reflect the recent
> PM-related changes?
> > There seems to be quite some changes between 2.6.26
> and 2.6.27 .
> 
> It _has_ been updated.  But the USB PM interfaces allow
> several
> different modes of operation, and usb-skeleton can
> illustrate only one
> of them.

So it has... I found Documentation/usb/power-management.txt a bit brief...
and I am planning to read
http://ols.fedoraproject.org/OLS/Reprints-2008/brown-reprint.pdf
which seems to be quite relevant... do you have any recommended readings? I have tried "use the source", but the majority of wireless device drivers don't have any suspend/resume hooks :-). The behavior of 2.6.26pre - somewhere in usbcore forces unloading of all usb device drivers on suspend - was useable.

Hin-Tak


      
