From: Sundar <sunder.svit@gmail.com>
Subject: Re: Power Domain Framework
Date: Sat, 22 May 2010 09:32:10 +0530
Message-ID: <AANLkTinTdTp_X4lGtZ0hCaVJN5GmvI0tXR1RTRkRNkjN@mail.gmail.com>
References: <AANLkTinZU1D1rMOBQDi47tRhXrOXwduQIdni7bCXdce0@mail.gmail.com>
	<AANLkTiniwUDg8rQzwgm_X7EbkQJ9tHzBfVtaJRiNE9az@mail.gmail.com>
	<1274114107.20589.64.camel@bnru01>
	<1274115886.2698.22.camel@finisterre.wolfsonmicro.main>
	<1274118332.17303.17.camel@bnru01>
	<CEE6BB42CAD6E947908279175AF8470A025A726240@EXDCVYMBSTM006.EQ1STM.local>
	<1274131108.2698.161.camel@finisterre.wolfsonmicro.main>
	<CEE6BB42CAD6E947908279175AF8470A025A72624A@EXDCVYMBSTM006.EQ1STM.local>
	<1274134636.2698.170.camel@finisterre.wolfsonmicro.main>
	<1274162450.17303.35.camel@bnru01>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7593361177771470606=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274162450.17303.35.camel@bnru01>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Viresh KUMAR <viresh.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Armando VISCONTI <armando.visconti@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vipin KUMAR <vipin.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============7593361177771470606==
Content-Type: multipart/alternative; boundary=0016e645b94239991b048726df53

--0016e645b94239991b048726df53
Content-Type: text/plain; charset=ISO-8859-1

Hi,

> operating mode for the entire power domain. For example, I can see
> hardware requiring that if more than a given number of blocks are
> enabled at any level a higher operating point is selected.
To me, since such a requirement is a constraint on the regulator,
this can be added as a flag to the regulator details.
This flag can then be used in the set_opp* functions to check the
condition along with the client dependencies!

Thanx!
Sundar

--0016e645b94239991b048726df53
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; f=
ont-size: 13px; border-collapse: collapse; "><div class=3D"im" style=3D"col=
or: rgb(80, 0, 80); ">Hi,</div><div class=3D"im" style=3D"color: rgb(80, 0,=
 80); "><br>
</div><div class=3D"im" style=3D"color: rgb(80, 0, 80); ">&gt; operating mo=
de for the entire power domain. For example, I can see<br>&gt; hardware req=
uiring that if more than a given number of blocks are<br>&gt; enabled at an=
y level a higher operating point is selected.<br>
</div></span>To me, since such a requirement is=A0a constraint=A0on the reg=
ulator,=A0<div>this can be added as a flag to the regulator=A0details.=A0<d=
iv>This flag can then be used in the set_opp* functions to check the<div>co=
ndition along with the client=A0dependencies!</div>
<div><br></div><div>Thanx!</div><div>Sundar</div><div><br></div></div></div=
>

--0016e645b94239991b048726df53--

--===============7593361177771470606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7593361177771470606==--
