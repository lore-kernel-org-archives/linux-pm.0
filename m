From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: STD (suspend to disk) for ARM
Date: Sat, 30 May 2009 22:53:53 +0200
Message-ID: <200905302253.53651.rjw@sisk.pl>
References: <0137E6B5D7EF4619BEBD1F615E82108B@homeuser>
	<20090530112306.GC1395@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090530112306.GC1395@ucw.cz>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 30 May 2009, Pavel Machek wrote:
> On Tue 2009-05-26 21:13:25, aki wrote:
> >    Deal All,
> > 
> >    I wanted to implement STD (suspend to disk) on ARM926EJS.
> 
> Yes, it would be nice. Look how x86 does it, then modify it to save
> arm's registers....

Also some assembly code to restore the last part of the image is necessary.

Best,
Rafael
