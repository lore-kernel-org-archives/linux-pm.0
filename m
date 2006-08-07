From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: PowerOp Design and working patch
Date: Mon, 7 Aug 2006 09:12:14 -0500 (CDT)
Message-ID: <200608071412.k77ECEQD009852@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Greg KH's message of Sun, 6 Aug 2006 21:17:46 -0700
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: greg@kroah.com
Cc: daviado@gmail.com, linux-pm@lists.osdl.org, dsingleton@mvista.com, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


While I think it makes sense to treat a list as a "single value" in this
kind of case, a reasonable alternative would be to make
/sys/power/supported_states a directory, with separate files for each
supported OP.

scott

| From: Greg KH<greg@kroah.com>
| =

| On Sun, Aug 06, 2006 at 08:52:15PM -0700, david singleton wrote:
| > =

| > On Aug 6, 2006, at 3:05 PM, Pavel Machek wrote:
| > =

| > > Hi!
| > >
| > >>> 2) interface (kernel as well as userspace(sysfs)) for the rest of =

| > >>> power
| > >>>    parameters except cpu voltage and frequency
| > >>
| > >>
| > >> The /sys/power/supported_states file shows the supported operating
| > >> points
| > >> and their parameters.
| > >
| > > We have one-value-per-file rule for sysfs.
| > =

| > Yes, the supported_states file would be better off in /proc.  I'll
| > move it.
| =

| No, don't put non-process stuff in /proc, that's not where it belongs.
| =

| > I just put it in /sys because it was so easy.
| =

| Then use the proper interface with sysfs please.
| =

| Just listing the supported states is acceptable, there is prior-usages
| like this.  Just not the paramaters, this doesn't need to be
| self-documented...
| =

| Or use configfs, that might be good for something like this.
| =

| thanks,
| =

| greg k-h
| _______________________________________________
| linux-pm mailing list
| linux-pm@lists.osdl.org
| https://lists.osdl.org/mailman/listinfo/linux-pm
| =


-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
