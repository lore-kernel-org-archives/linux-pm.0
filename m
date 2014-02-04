From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v7 3/3] PM / Hibernate: use name_to_dev_t to parse resume
Date: Tue, 04 Feb 2014 15:17:10 -0800
Message-ID: <20140204231710.31169.6504@capellas-linux>
References: <1391546631-7715-1-git-send-email-sebastian.capella@linaro.org>
 <1391546631-7715-4-git-send-email-sebastian.capella@linaro.org>
 <1498007.FMXxByppC2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1498007.FMXxByppC2@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2014-02-04 13:39:43)
> On Tuesday, February 04, 2014 12:43:51 PM Sebastian Capella wrote:
> > +     if (name =3D=3D NULL)
> What about "if (!name)"?
> > +     if (res !=3D 0) {
> What about "if (res)"?

Changed, thanks!

Sebastian

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
