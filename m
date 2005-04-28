From: Pavel Machek <pavel@suse.cz>
Subject: Re: freeze_processes questions
Date: Thu, 28 Apr 2005 20:47:06 +0200
Message-ID: <20050428184706.GB12431@elf.ucw.cz>
References: <1114595634.7918.25.camel@desktop.cunningham.myip.net.au>
	<1114663706.22110.35.camel@sli10-desk.sh.intel.com>
	<20050428081435.GE1906@elf.ucw.cz> <4270FF11.70305@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81271923098719223=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <4270FF11.70305@suse.de>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Seyfried <seife@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

--===============81271923098719223==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > How can usespace processes depend on each other? By definition user
> > task sleeps in place where it holds no locks... it can't block anyone.
> 
> what was the problem with mysql some months back? I never fully
> understood it, but wasn't it 2 mysql processes communicating via a pipe
> or something like that and the "wrong end" frozen first?

I never fully understood it, either (it still exists in mainline,
IIRC), but it apparently was process calling signal functions in too
tight loop. It was reproducible with just one process.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============81271923098719223==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81271923098719223==--
