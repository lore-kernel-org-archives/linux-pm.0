From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: suspend and hibernate nomenclature
Date: Tue, 16 May 2006 15:47:08 -0500 (CDT)
Message-ID: <200605162047.k4GKl8P5002991@olwen.urbana.css.mot.com>
Content-Type: multipart/mixed; boundary="===============14627433136933532=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Richard Hughes's message of Sun, 14 May 2006 16:32:24 +0100
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============14627433136933532==


| On Mon, 2006-05-08 at 20:01 +0000, Pavel Machek wrote:
| > Hi!
| > 
| > > Full description of the problem is here:
| > > http://live.gnome.org/GnomePowerManager/SleepNames and I would encourage
| > > you guys to add comments to the end of the wiki if required.
| > 
| > Please do not use word 'thaw'. We already freeze processes during
| > suspend, and we thaw them during resume.
| 
| Got any better ideas? It needs to *just* apply to hibernation, not a
| generic term like wake.
---

Well, it's not pretty, but using an "un-" prefix is generally
well-understood.  So, suspend/unsuspend, hibernate/unhibernate.

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



--===============14627433136933532==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14627433136933532==--
