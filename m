From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Add include/linux/freezer.h and move
	definitions from sched.h
Date: Sat, 21 Oct 2006 15:41:18 +0200
Message-ID: <200610211541.19050.rjw@sisk.pl>
References: <1161433266.7644.7.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1161433266.7644.7.camel@nigel.suspend2.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, suspend2-devel <suspend2-devel@lists.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, 21 October 2006 14:21, Nigel Cunningham wrote:
> Move process freezing functions from include/linux/sched.h to freezer.h,

Hm, I'd rather move them to suspend.h.  Is there any reason for introducing
yet another header file?

> so that modifications to the freezer or the kernel configuration don't
> require recompiling just about everything.

Yes, that's annoying.

Greetings,
Rafael
