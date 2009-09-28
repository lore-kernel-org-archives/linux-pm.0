From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] Help
Date: Tue, 29 Sep 2009 00:27:08 +0200
Message-ID: <200909290027.08115.rjw__16411.9346686222$1254176827$gmane$org@sisk.pl>
References: <E1McOLX-0003Lq-BN@665xhf1.ch3.sourceforge.com>
	<5B7CD99A-A3B3-44EC-A073-31C0A5B7286B@gmail.com>
	<3096bd910909281513h134e505cy6631f998cd1cba5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <3096bd910909281513h134e505cy6631f998cd1cba5b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rodolfo (kix)" <kix@kix.es>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, kix <kixdotes@users.sourceforge.net>, pm list <linux-pm@lists.linux-foundation.org>, Stefan Seyfried <stefan.seyfried@googlemail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 29 September 2009, Rodolfo (kix) wrote:
> Hi!!

Hi,

> 1. A new database file, comma separated, has been created (it was
> terrible, I am very tired)

Well, I can imagine. :-)

> 2. A little script to search in the database (using the "match"
> function) is implemented
> 3. Other script to convert the database file to whitelist.c has been
> created too.
> 
> The scripts has been created using perl. Why? because is fast, good
> and is only for the database maintaning, not for the code
> distribution.
> 
> Please, test it, the code is in http://www.kix.es/20090929/

OK, so the idea is that users wanting to add an entry to the whitelist will
edit the whitelist file and the use your script to generate a new
whitelist.c before building s2ram.  Is this correct?

Rafael
