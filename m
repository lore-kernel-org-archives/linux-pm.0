From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP take 3, PowerOP core 1/5
Date: Wed, 26 Jul 2006 17:18:36 -0700
Message-ID: <200607261718.38551.david-b@pacbell.net>
References: <c55240ed0607201250x5f77c473m381f1698f1168e52@mail.gmail.com>
	<200607201501.32087.david-b@pacbell.net>
	<44C7D438.6090208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44C7D438.6090208@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 July 2006 1:44 pm, Eugeny S. Mints wrote:

> basically agree. The reference code is handling only one arch layer
> (essentially PM core) underneath PowerOP for the time being though.

I'm not sure it's practical to standardize more than one such layer yet.
Boards based on one SOC could share much code ... ditto ones using the
same external PM chip(s).  But "layer" isn't necessarily the right model
for integration (except in slideware, of course).  The value of such
PM componentry will show with whole/real systems though.

- Dave
