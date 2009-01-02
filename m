From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Thu, 1 Jan 2009 21:24:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901012121350.10174-100000__38495.5699475997$1230863229$gmane$org@netrider.rowland.org>
References: <26416.81498.qm@web23106.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <26416.81498.qm@web23106.mail.ird.yahoo.com>
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

> So it has... I found Documentation/usb/power-management.txt a bit brief...
> and I am planning to read
> http://ols.fedoraproject.org/OLS/Reprints-2008/brown-reprint.pdf
> which seems to be quite relevant...

It doesn't cover USB suspend/resume specifically.  But maybe it will 
help you.

> do you have any recommended readings? I have tried "use the source",
> but the majority of wireless device drivers don't have any
> suspend/resume hooks :-). The behavior of 2.6.26pre - somewhere in
> usbcore forces unloading of all usb device drivers on suspend - was
> useable.

There aren't any other good documents to read, as far as I know.  
2.6.28 also forces unloading of all USB drivers that don't have 
suspend/resume support -- that was the part of the problem which 
started this thread.

Alan Stern
