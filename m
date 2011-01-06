From: Kevin Hilman <khilman@ti.com>
Subject: Re: Status of the PM links framework
Date: Thu, 06 Jan 2011 13:58:15 -0800
Message-ID: <878vyxu22w.fsf@ti.com>
References: <201012201444.01510.laurent.pinchart@ideasonboard.com>
	<201012202339.02468.rjw@sisk.pl>
	<201012210041.54652.laurent.pinchart@ideasonboard.com>
	<201012241521.10155.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012241521.10155.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 24 Dec 2010 15:21:10 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[...]

>
> Please note, however, that this only applies to _system_ suspend/resume, it
> doesn't cover runtime PM at all.
>

This is a very interesting point, since on OMAP we are heavily using
runtime PM, and only occasionally using system PM.  Any PM dependency
solution will need to work for both.

Kevin
