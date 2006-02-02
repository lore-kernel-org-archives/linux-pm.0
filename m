From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Thu, 2 Feb 2006 15:08:30 +0000
Message-ID: <20060202150830.GA8944@ucw.cz>
References: <200602010141.53974.rjw@sisk.pl> <20060201124950.GA2137@elf.ucw.cz>
	<200602020057.35598.rjw@sisk.pl> <200602021455.01745.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36789672596773171=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602021455.01745.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============36789672596773171==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> That requires a timeout in case we have a user mode helper in the D state.
> The corrected patch is appended.
> 
> BTW, it contains a change that may help solve the unfreezeable gcc problem
> that has appeared in your tests.  Could you please try it or tell me what I
> should do to reproduce the problem?

I'm away from real macine just now... I could reproduce it with
Nigel's "stress ..." command, then trying to build kernel.

								Pavel

-- 
Thanks, Sharp!

--===============36789672596773171==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36789672596773171==--
