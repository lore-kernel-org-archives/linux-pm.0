From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: freeze_processes questions
Date: Thu, 28 Apr 2005 10:14:35 +0200
Message-ID: <20050428081435.GE1906@elf.ucw.cz>
References: <1114595634.7918.25.camel@desktop.cunningham.myip.net.au>
	<1114663706.22110.35.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31585419804741077=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1114663706.22110.35.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Li Shaohua <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

--===============31585419804741077==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > That's right, but the example you give below is userspace (syslogd) vs
> > kernel space (kjournald), so I wonder if something could be wrong with
> > your implementation.
> Right, my example can be solved with your patch. But I'd like a more
> generic solution to solve all the dependences, like user space tasks
> dependencies.

How can usespace processes depend on each other? By definition user
task sleeps in place where it holds no locks... it can't block anyone.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============31585419804741077==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31585419804741077==--
