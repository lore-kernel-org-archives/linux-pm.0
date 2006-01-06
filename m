From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 18:31:11 -0600 (CST)
Message-ID: <200601060031.k060VBDV000727@olwen.urbana.css.mot.com>
Content-Type: multipart/mixed; boundary="===============32971402686594065=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Patrick Mochel's message of Thu, 5 Jan 2006 16:02:29 -0800 (PST)
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: mochel@digitalimplant.org
Cc: akpm@osdl.org, pavel@ucw.cz, linux-pm@lists.osdl.org, scott.preece@motorola.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============32971402686594065==


OK - sorry, my misparsing of what you asked. I agree that wakeup would
always be caused by some single device, not by multiple devices.

scott

| From mochel@digitalimplant.org Thu Jan  5 18:04:42 2006
| Date: Thu, 5 Jan 2006 16:02:29 -0800 (PST)
| From: Patrick Mochel<mochel@digitalimplant.org>
| cc: Pavel Machek<pavel@ucw.cz>, Alan Stern<stern@rowland.harvard.edu>,
| 
| 
| On Thu, 5 Jan 2006, Preece Scott-PREECE wrote:
| 
| > This is, of course, in an embedded framework rather than a desktop
| > framework - we suspend and wakeup automatically, not via user
| > intervention. Answering a question asked in another piece of mail, we
| > have roughly a dozen different devices that cause the system to wakeup -
| > keypad press, touchscreen touch, flip open/close, etc.
| 
| Hmm, it would be nice if that comment was in reply to the email in which
| it came. At least if it was in the same thread..
| 
| Many systems have > 1 _possible_ wakeup devices (keyboard, touchscreen,
| lid, etc). You implied that when a system wakes up, there could be > 1
| device that actually woke the system up, which is in direct conflict with
| what I've always assumed - that when a system wakes up, it is caused by a
| single device (and if there were multiple events, like a key press *and* a
| mouse movement, it's doesn't really matter)..
| 
| Thanks,
| 
| 
| 	Patrick
| 
| 

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



--===============32971402686594065==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32971402686594065==--
