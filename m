From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/2] swsusp: Remove platform callbacks
	from restore code
Date: Wed, 9 May 2007 15:19:19 +0200
Message-ID: <200705091519.19922.rjw__14242.9795502268$1178730634$gmane$org@sisk.pl>
References: <200705052227.14265.rjw@sisk.pl> <200705090027.05735.rjw@sisk.pl>
	<8f8ff01d0705082358t74c08b5dja18e1c8b6c8e53e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8f8ff01d0705082358t74c08b5dja18e1c8b6c8e53e8@mail.gmail.com>
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
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, suspend-devel@lists.sourceforge.net, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 9 May 2007 08:58, Alexey Starikovskiy wrote:
> I expect http://bugzilla.kernel.org/show_bug.cgi?id=7887 this bug to
> pop again with this patch.

Well, this change only reflects what's done in kernel/power/disk.c .

Greetings,
Rafael
