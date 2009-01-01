From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Thu, 1 Jan 2009 17:25:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901011724590.5737-100000__12936.3805790947$1230849033$gmane$org@netrider.rowland.org>
References: <584629.91849.qm@web23108.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <584629.91849.qm@web23108.mail.ird.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hin-Tak Leung <htl10@users.sourceforge.net>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-pm@lists.linux-foundation.org, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 1 Jan 2009, Hin-Tak Leung wrote:

> Also since Alan Stern is now CC'ed, can I ask the in-tree skeleton
> usb driver code updated to reflect the recent PM-related changes?
> There seems to be quite some changes between 2.6.26 and 2.6.27 .

It _has_ been updated.  But the USB PM interfaces allow several
different modes of operation, and usb-skeleton can illustrate only one
of them.

Alan Stern
