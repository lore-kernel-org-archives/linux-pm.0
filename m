From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] How to turn off graphics to save
	energy?
Date: Thu, 1 Oct 2009 22:52:47 +0200
Message-ID: <200910012252.47665.rjw__43149.9553648338$1254430376$gmane$org@sisk.pl>
References: <4AC49C5D.4040209@voddler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AC49C5D.4040209@voddler.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: per =?iso-8859-1?q?j=E4gmalm?= <per.jagmalm@voddler.com>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 01 October 2009, per j=E4gmalm wrote:
> but let the rest of the machine run..

I believe X drivers allow you to do that to some extent.  Beyond that you'd
need a kernel support for such things which is missing at the moment.

Thanks,
Rafael
