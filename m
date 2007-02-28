From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/PATCH 2/3] Allow objects other than "struct
	device" in pm list
Date: Wed, 28 Feb 2007 16:20:51 -0500
Message-ID: <d120d5000702281320k349e762bqcf05c1e63555a4f0@mail.gmail.com>
References: <20061011060138.920913139.dtor@insightbb.com>
	<20061011061030.258583307.dtor@insightbb.com>
	<200702281024.10384.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702281024.10384.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi David,

It appears that your unread lists backlog is even longer than mine ;)

On 2/28/07, David Brownell <david-b@pacbell.net> wrote:
>
> > Any object with embedded dev_pm_info structure can be added to
> > ower management list and have its suspend/resume methods called
> > automatically by driver core.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>
> This patch was interesting ... was there followup that I missed?

Yes, there was:
http://lists.osdl.org/pipermail/linux-pm/2006-October/003927.html

> (The patch 3/3, teaching class_device how to do PM, seems like it's
> not a good approach, now that class suspend/resume can work.)
>

Now the point is moot; I was just trying to do class device
suspend/resume without wholesale conversion to struct device requiring
entire tree shakeup.

-- =

Dmitry
