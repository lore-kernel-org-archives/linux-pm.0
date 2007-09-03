From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 5/5] Hibernation: Introduce exportable
	suspend ioctls header
Date: Mon, 3 Sep 2007 23:15:13 +0200
Message-ID: <200709032315.13911.rjw@sisk.pl>
References: <200709022315.59652.rjw@sisk.pl> <200709022328.20720.rjw@sisk.pl>
	<20070903032934.GI21721@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070903032934.GI21721@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 3 September 2007 05:29, Pavel Machek wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Move the definitions of hibernation ioctls to a separate header file in
> > include/linux, which can be exported to the user space.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK, but this depends on previous patches that need fixes. Perhaps
> this should be moved to the begging of series?

Hm, the whole point of some patches in the series is to prepare for this one ...

Greetings,
Rafael
