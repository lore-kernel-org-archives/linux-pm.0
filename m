From: Patrick Mochel <mochel@linux.intel.com>
Subject: Re: RE: on-ness
Date: Thu, 27 Apr 2006 10:01:15 -0700
Message-ID: <20060427170115.GB3113@linux.intel.com>
References: <200604271412.k3RECVA2009467@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76261898533512595=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604271412.k3RECVA2009467@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: david-b@pacbell.net, linux-pm@lists.osdl.org, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

--===============76261898533512595==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2006 at 09:12:31AM -0500, Scott E. Preece wrote:

> So, is the sum of this conversation to this point that it simply isn't
> possible to come up with a set of names and attributes that are
> meaningful across devices? Or might it be possible to map the set of
> special conditions (like the "NoSoftReset" below) to a common vocabulary
> that a device could expose to power management and that a generic,
> cross-platform power management facility could map to system states and
> transitions?

Both. :-)

You can come up with some names and attributes that are common across
devices, and those should be leveraged when possible. But, I don't think
it's possible, or worthwhile, to try to map every device state to a common,
generic (i.e. limited) vocabulary. 

You want drivers to export the states that they know about, in the format
that makes the most to them (e.g. PCI D0-D3), instead of having them 
scratch their head about what to name the states. 

>From that point (when they're exported), it's pretty simple to condense the
vocbulary into something that makes more sense for the platform (like, "on",
"off", "more off", etc).


	Patrick

--===============76261898533512595==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76261898533512595==--
