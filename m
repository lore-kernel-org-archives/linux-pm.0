From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 11/16 v3] Make wakeup bias threshold changeable via
 sysctl
Date: Tue, 3 Jun 2014 14:23:09 +0200
Message-ID: <20140603122309.GK30445@twins.programming.kicks-ass.net>
References: <1401431772-14320-1-git-send-email-yuyang.du@intel.com>
 <1401431772-14320-12-git-send-email-yuyang.du@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9Nh279w3tr8TrRk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401431772-14320-12-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuyang Du <yuyang.du@intel.com>
Cc: mingo@redhat.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, pjt@google.com, bsegall@google.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, fengguang.wu@intel.com
List-Id: linux-pm@vger.kernel.org


--+9Nh279w3tr8TrRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2014 at 02:36:07PM +0800, Yuyang Du wrote:
> In wakeup balance, we bias wakee and waker (in this order) if it is capab=
le
> of handling the wakee task.
>=20
> sysctl_sched_cc_wakeup_threshold is the threshold to see whether the CPU
> is capable, and can be changed by sysctl tool

This must strive for the most useless changelog ever..=20

--+9Nh279w3tr8TrRk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTjb4tAAoJEHZH4aRLwOS61sMP/1HHLdLOKb/ULUoa7I3lDEmh
JZWMdwhn+XfHH3u5imbStMapLaxfk1SnhfcZluzpj+5qxsSY2mwnMng62fW+9Auy
9Uw6oADoUe/rrAMziNzxFgj8va2tvcB7eyjQHCLy5aTe3nV12iHg3g8Ox4zIJTyc
hzp5MFzbsLxYNu1SQ2kL+L8ZW6y2CT5ci2wK62wYskwCDY0FnG5Hd0nTjLtnjXXa
RjGmAu8fxvAji2AUfaoqC4HCacRP85FnoqI95EohcmJs3eZzh2ADrJ3xBSmF339A
X3WFWfqrJo8Js5GsQYr11XfshjiyXT79vVUpj67xPtdWp4sFnZHww/eSGidJAFcC
+0biQEt37WKXArbZqyxr8u80D4cJM+ja3lj6JFDDuaiTpKMqJe2HmqoX08e/UuHg
gqu4tGCtIEUI/UqNNIl7Un1ySxcIa3dwj0H6jcGD10xcPKUx8GDaISuvvouMS02o
YsNDwAQ/c4tJuGLMV2DOW/FxRnuD3ehiYv+3dvwCzmR6/1fuQqo7eDz/vIp4dj5g
9mPCaLZK48OSfQgNm9d64aYra6q4N5iulhdq1fMtc0/0xBGtfSnqRQkId0st82pT
2YSyZkHTru5YovTXG2KgbI2Jk+kGv5fkZRq4Z3cyj/2oVJVhvlLtqHGWJ1Z7Tv8r
r9/tXvpNpltvyehZCcPM
=IlEk
-----END PGP SIGNATURE-----

--+9Nh279w3tr8TrRk--
