From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Documentation: power: swsusp: Fix script for unswapping
Date: Sat, 16 Aug 2014 17:42:30 +0200
Message-ID: <20140816154230.GB12400@Nokia-N900>
References: <1399374116-12400-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399374116-12400-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Pali Roh?r <pali.rohar@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2014-05-06 13:01:56, Pali Roh?r wrote:
> System can have mmaped also character devices (e.g dri devices by X) =
or deleted
> files. Running cat on character devices is really bad idea (system ca=
n hang) so
> run cat only on regular files. Also mmaped files can have spaces in f=
ilenames.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  Documentation/power/swsusp.txt |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/power/swsusp.txt b/Documentation/power/sws=
usp.txt
> index 079160e..f732a83 100644
> --- a/Documentation/power/swsusp.txt
> +++ b/Documentation/power/swsusp.txt
> @@ -220,7 +220,10 @@ Q: After resuming, system is paging heavily, lea=
ding to very bad interactivity.
> =20
>  A: Try running
> =20
> -cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` > /=
dev/null
> +cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u | while r=
ead file
> +do
> +  test -f "$file" && cat "$file" > /dev/null
> +done
> =20
>  after resume. swapoff -a; swapon -a may also be useful.
> =20
> --=20
> 1.7.9.5

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
