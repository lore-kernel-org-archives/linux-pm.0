From: Pavel Machek <pavel@suse.cz>
Subject: Re: suspend and hibernate nomenclature
Date: Mon, 8 May 2006 20:01:03 +0000
Message-ID: <20060508200103.GB4312@ucw.cz>
References: <1147024930.16057.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============56123967499424599=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1147024930.16057.3.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: richard@hughsie.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============56123967499424599==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> First, sorry for the random mail to this mailing list.
> 
> I'm the developer of gnome-power-manager. The latest mini-project of
> mine is to fix the suspend-hibernate nomenclature used by OSS projects.
> 
> This might not effect the lowest layers of the stack (i.e. I want to
> focus on the stuff used by *users*), so this might not be applicable to
> you guys. Please keep me cc'd if you discuss, as I'm not subscribed to
> this list.
> 
> Full description of the problem is here:
> http://live.gnome.org/GnomePowerManager/SleepNames and I would encourage
> you guys to add comments to the end of the wiki if required.

Please do not use word 'thaw'. We already freeze processes during
suspend, and we thaw them during resume.
							Pavel

-- 
Thanks for all the (sleeping) penguins.

--===============56123967499424599==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============56123967499424599==--
