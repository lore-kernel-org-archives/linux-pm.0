From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: Regulators vis-a-vis Power Domains
Date: Sat, 3 Apr 2010 20:12:56 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B180320EBB6__21071.6546782807$1270318480$gmane$org@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: linux-pm@vger.kernel.org

Hello All,
=A0
I have a few queries about regulators vis-a-vis power domains.
=A0
1. The documentation for the regulators mentions "power domains" and "switc=
hes" to be modeled as regulators. I am planning to model multiple "switches=
" for controlling supplies to various peripherals from a main master regula=
tor as multiple regulators, childed from the parent regulator. Is this the =
right way to proceed ahead? Further the options for these switches will be =
only=A0a logical on/off. (BTW, I saw lots of TI stuff which is something re=
lated to power domains, but it doesn't model the regulator framework.)
=A0
2. In the same example below, should I instead model just the main regulato=
r, and in the driver specific enable/disable, iterate through the list of c=
onsumers, and then accordingly enable/disable these switches according to t=
he calling consumer?. In this way,=A0I can choose not to clutter those smal=
ler switches as regulators in my regulator as well as peripheral driver cod=
e.?
=A0
3. Extending the same model, I want to use the _set_optimum API. Logically,=
 enabling/disabling the child supply or setting an optimal load on the regu=
lator must propagate the new load to any master regulator ( which can then =
again be set an optimal load). My understanding of this function shows me t=
hat=A0currently, this is not supported in the function. Am I right in deduc=
ing this or=A0have I failed to overlook some other portions in the regulato=
r code?
=A0
Waiting for all your valuable replies!
=A0
Sundar
