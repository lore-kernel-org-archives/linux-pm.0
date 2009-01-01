From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Thu, 01 Jan 2009 10:38:27 -0600
Message-ID: <495CF183.10107__5534.06252661279$1230910732$gmane$org@lwfinger.net>
References: <120849.67182.qm@web23104.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <120849.67182.qm@web23104.mail.ird.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: htl10@users.sourceforge.net
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, =?ISO-8859-1?Q?G=E1bor?= <netrolller.3d@gmail.com>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-pm@lists.linux-foundation.org, =?ISO-8859-1?Q?Stefanik_?=@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hin-Tak Leung wrote:
> 
> Yes, that's the (older) non-B device. B devices says RTL8187Bv{B,D,E} . with a B before the 7; I have a rev E .The B device and the non-B device while similiar enough to share some driver code, are different enough that
> they might suspend/resume differently - they do probe/init slightly differently. Besides, I think all the people who recently worked on that code are B-device owners, with maybe Larry who probably owns both types (or a few).

I only have one. It is the strange device that reports an 8187 USB ID,
but is really an 8187B.

Larry
