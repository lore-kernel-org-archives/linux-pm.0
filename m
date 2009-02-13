From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 17:49:57 +0100
Message-ID: <200902131749.57728.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213140654.GC26549@srcf.ucam.org>
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
Cc: "ncunningham@crca.org.au" <ncunningham@crca.org.au>, "swetland@google.com" <swetland@google.com>
List-Id: linux-pm@vger.kernel.org

On Friday, 13. February 2009, Matthew Garrett wrote:
> Userland ABI would then be a single /dev/inhibit_suspend,
> with the counter being bumped each time an application opens it. It'll
> automatically be dropped if the application exits without cleaning up.
>
> This seems simpler and also avoids any arguments about the naming
> scheme. What am I missing?
Opening and closing an fd sounds like a lot of overhead. Taking and releasing 
locks if going to be a called with very highg frequency. I'd go for an ioctl.

Uli


-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
