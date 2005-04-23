From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] Power Management API (rev 1)
Date: Sat, 23 Apr 2005 03:23:58 -0400
Message-ID: <20050423072358.GD27771@neo.rr.com>
References: <1113773748.3451.142.camel@localhost.localdomain>
	<20050420155956.GA3372@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============13109530667552916=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050420155956.GA3372@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Adam Belay <abelay@novell.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============13109530667552916==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2005 at 05:59:56PM +0200, Pavel Machek wrote:
-->snip
> 
> We already have int system_state... How is this different?
> 
-->snip
> 
> Having "unsigned int state" is asking for trouble.
> 
-->snip
> 
> Are they same type as system_power_state.state? This should be clear,
> and type-checked by sparse. Otherwise people will get it wrong.
> 
> 

Hi Pavel,

I appreciate the suggestions.  I'm currently making some revisions.  I'll
clarify things further once they're ready.

Thanks,
Adam

--===============13109530667552916==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============13109530667552916==--
