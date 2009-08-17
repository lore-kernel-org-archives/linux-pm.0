From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Mon, 17 Aug 2009 23:33:53 +0200
Message-ID: <4A89CCC1.8020306@gmail.com>
References: <200908172028.26817.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0908171640590.2680-100000@iolanthe.rowland.org>
	<20090817211413.GA30252@kroah.com>
	<20090817211514.GA30538@kroah.com> <4A89CC44.2000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A89CC44.2000506@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On 08/17/2009 11:31 PM, Jiri Slaby wrote:
> Anyway I use the following. The function is called with interrupts
> disabled during resume. Won't it help you by a chance?

No way, sorry, this is also a -next thing.
