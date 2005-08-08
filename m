From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: swsusp limits
Date: Mon, 8 Aug 2005 13:09:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.50.0508081248540.1704-100000@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37022543639054195=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@suse.cz
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============37022543639054195==
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi Pavel,

Is there a maximum system RAM size that is supported by swsusp?

Does swsusp (to disk) use only one swap partition or can it use
multiple swap partitions (aggregate them into one logical space)?

Is there an option or possibility of using a dedicated swap
partition for suspend to disk?
Or maybe there is no reason to think that this might help?

If my application(s) causes lots of memory & swap space
to be used (over half of the total system RAM), is it correct
that it is likely to be useless to try to suspend to disk
while that app is running?
or should I try to use suspend2 instead?

Thanks,
-- 
~Randy

--===============37022543639054195==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============37022543639054195==--
