From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: Alternative Concept
Date: Wed, 14 Mar 2007 17:08:56 -0500 (CDT)
Message-ID: <200703142208.l2EM8uoV007606@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: David Brownell's message of Wed, 14 Mar 2007 11:45:04 -0700
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david-b@pacbell.net
Cc: linux-pm@lists.osdl.org, linux@dominikbrodowski.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org



| From: David Brownell<david-b@pacbell.net>
| ...
| > > > Basically a good way of thinking about parameter framework is that =
parameter =

| > > > framework would start from existed clock framework and gradually ev=
olve by =

| > > > addressing voltages, relationship between clocks and voltages, doma=
ins. =

| > > > Eventually clock framework functionality would be a part of power p=
arameter =

| > > > framework.
| > > =

| > > A better way would be to say that implementions of the clock interface
| > > on a given platform can build on whatever they need to build.  That m=
ight
| > > include a "parameter" framework, if such a thing were defined in such
| > > a way that it became useful to such implementations.
| > > =

| > But shouldn't it be useful on every platform? As a sort of resource
| > manager (because that's what it would become if it would start adressing
| > interdependencies between clocks and voltages).
| =

| I couldn't know.  This "alternative concept" hasn't gotten very far
| into the hand-waving stage, much less beyond it into proposed interface
| or (gasp!) implementations.  Platforms that don't *have* those particular
| interdependencies should not of course incur costs to implement them...
---

Well, that's fine if the platform you use is the current design
center. For the rest of us, though, all the stuff you're currently
doing for power management is wasted effort and why should we incur
costs to work around them?  Today, we just configure it all out and put
in our own stuff. We would prefer to have a mainstream framework that
could be used to meet both Intel laptop needs and embedded device needs...

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
