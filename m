From: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] A New Power Management API
Date: Fri, 15 Apr 2005 14:20:25 -0400
Message-ID: <1113589226.3451.46.camel@localhost.localdomain>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<9268368b0504150616652c268b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48060229438941082=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <9268368b0504150616652c268b@mail.gmail.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Daniel Petrini <d.pensator@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============48060229438941082==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-04-15 at 09:16 -0400, Daniel Petrini wrote:
> Hi,
> 
> Suggestion: as discussed in early weeks, why don't adopt names taking
> into consideration that Linux can run in systems other than desktops
> and servers?
> 
> #define PM_SYSTEM_STATE_SUSPEND_RAM     0x00000010
> #define PM_SYSTEM_STATE_SUSPEND_DISK    0x00000020
> 
> PM_SYSTEM_STATE_SUSPEND_DISK an be something like
> PM_SYSTEM_STATE_DEEP_SUSPEND and so on...
> 
> So you can have better acceptance of people working in other areas.
> 
> My two cents.
> Regards,
> 
> Daniel Petrini

My idea here was to provide some optional flags that describe
characteristics of a given system-specific state.  They may need to be
revised, but the intention was to provide meaningful information to
drivers without architecture specific code.  Architecture-specific
drivers will likely ignore these and pay more attention to the state
number.

Thanks,
Adam



--===============48060229438941082==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48060229438941082==--
